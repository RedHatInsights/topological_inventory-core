require "topological_inventory/persister/logging"

module TopologicalInventory
  module Persister
    class Workflow
      include Logging

      def initialize(persister, messaging_client, payload)
        @persister        = persister
        @messaging_client = messaging_client
        # TODO(lsmola) we should be able to reconstruct the payload out of persistor? E.g. to just repeat the sweep phase
        @payload = payload
      end

      def execute!
        if total_parts
          sweep_inactive_records!
        else
          persist_collections!
        end
      end

      private

      attr_reader :persister, :messaging_client, :payload
      delegate :inventory_collections,
               :manager,
               :persist!,
               :refresh_state_uuid,
               :refresh_state_part_uuid,
               :total_parts,
               :sweep_scope,
               :to => :persister

      def define_refresh_state_ics
        refresh_states_inventory_collection = ::InventoryRefresh::InventoryCollection.new(
          :manager_ref                 => [:uuid],
          :saver_strategy              => :concurrent_safe_batch,
          :parent                      => manager,
          :association                 => :refresh_states,
          :create_only                 => true,
          :model_class                 => RefreshState,
          :inventory_object_attributes => %i(ems_id uuid status source_id tenant_id),
          :default_values              => {
            :source_id => manager.id,
            :tenant_id => manager.tenant_id,
          }
        )

        refresh_state_parts_inventory_collection = ::InventoryRefresh::InventoryCollection.new(
          :manager_ref                 => %i(refresh_state uuid),
          :saver_strategy              => :concurrent_safe_batch,
          :parent                      => manager,
          :association                 => :refresh_state_parts,
          :create_only                 => true,
          :model_class                 => RefreshStatePart,
          :inventory_object_attributes => %i(refresh_state uuid status error_message),
          :default_values              => {
            :tenant_id => manager.tenant_id,
          }
        )

        return refresh_states_inventory_collection, refresh_state_parts_inventory_collection
      end

      def upsert_refresh_state_records(status: nil, refresh_state_status: nil, error_message: nil)
        refresh_states_inventory_collection, refresh_state_parts_inventory_collection = define_refresh_state_ics

        return unless refresh_state_uuid

        build_refresh_state(refresh_states_inventory_collection, refresh_state_status)
        build_refresh_state_part(refresh_states_inventory_collection, refresh_state_parts_inventory_collection,
                                 status, error_message)

        InventoryRefresh::SaveInventory.save_inventory(
          manager, [refresh_states_inventory_collection, refresh_state_parts_inventory_collection]
        )
      end

      def build_refresh_state(refresh_states_inventory_collection, refresh_state_status)
        return unless refresh_state_status

        refresh_states_inventory_collection.build(
          :uuid   => refresh_state_uuid,
          :status => refresh_state_status,
        )
      end

      def build_refresh_state_part(refresh_states_ic, refresh_state_parts_ic, status, error_message)
        return unless status

        refresh_state_part_data = {
          :uuid          => refresh_state_part_uuid,
          :refresh_state => refresh_states_ic.lazy_find(:uuid => refresh_state_uuid),
          :status        => status
        }
        refresh_state_part_data[:error_message] = error_message if error_message

        refresh_state_parts_ic.build(refresh_state_part_data)
      end

      # Persists InventoryCollection objects into the DB
      def persist_collections!
        upsert_refresh_state_records(:status => :started, :refresh_state_status => :started)

        persist!

        upsert_refresh_state_records(:status => :finished)
      rescue StandardError => e
        upsert_refresh_state_records(:status => :error, :error_message => e.message.truncate(150))

        raise(e)
      end

      # Sweeps inactive records based on :last_seen_at attribute
      def sweep_inactive_records!
        refresh_state = set_sweeping_started!

        refresh_state.update!(:status => :waiting_for_refresh_state_parts, :total_parts => total_parts, :sweep_scope => sweep_scope)

        if total_parts == refresh_state.refresh_state_parts.count
          start_sweeping!(refresh_state)
        else
          wait_for_sweeping!(refresh_state)
        end
      rescue StandardError => e
        refresh_state.update!(:status => :error, :error_message => "Error while sweeping: #{e.message.truncate(150)}")

        raise(e)
      end

      def set_sweeping_started!
        refresh_state = manager.refresh_states.find_by(:uuid => refresh_state_uuid)
        unless refresh_state
          upsert_refresh_state_records(:refresh_state_status => :started)

          refresh_state = manager.refresh_states.find_by!(:uuid => refresh_state_uuid)
        end

        refresh_state
      end

      def start_sweeping!(refresh_state)
        error_count = refresh_state.refresh_state_parts.where(:status => :error).count

        if error_count.positive?
          refresh_state.update!(:status => :error, :error_message => "Error when saving one or more parts, sweeping can't be done.")
        else
          refresh_state.update!(:status => :sweeping)
          InventoryRefresh::SaveInventory.sweep_inactive_records(manager, inventory_collections, refresh_state)
          refresh_state.update!(:status => :finished)
        end
      end

      def wait_for_sweeping!(refresh_state)
        sweep_retry_count = refresh_state.sweep_retry_count + 1

        if sweep_retry_count > sweep_retry_count_limit
          refresh_state.update!(
            :status        => :error,
            :error_message => "Sweep retry count limit of #{sweep_retry_count_limit} was reached."
          )
        else
          refresh_state.update!(:status => :waiting_for_refresh_state_parts, :sweep_retry_count => sweep_retry_count)
          requeue_sweeping!
        end
      end

      def requeue_sweeping!
        logger.info("Re-queuing sweeping job...")
        messaging_client.publish_message(
          :service => "topological_inventory-persister",
          :message => "save_inventory",
          :payload => payload,
        )
      end

      def sweep_retry_count_limit
        100
      end
    end
  end
end
