require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Default < InventoryRefresh::Persister
      def initialize_inventory_collections
        add_containers
        add_cross_link_vms
        add_default_collection(:container_groups)
        add_default_collection(:container_images)
        add_default_collection(:container_nodes)    { |b| add_secondary_refs_name(b) }
        add_default_collection(:container_projects) { |b| add_secondary_refs_name(b) }
        add_default_collection(:container_templates)
        add_default_collection(:flavors)
        add_default_collection(:orchestration_stacks)
        add_default_collection(:service_instances)
        add_default_collection(:service_offerings)
        add_default_collection(:service_plans)
        add_default_collection(:source_regions)
        add_default_collection(:subscriptions)
        add_default_collection(:vms)
        add_taggings
        add_tags
      end

      def targeted?
        true
      end

      private

      def add_default_collection(model)
        add_collection(model) do |builder|
          add_default_properties(builder)
          add_default_values(builder)
          yield builder if block_given?
        end
      end

      def add_default_properties(builder, manager_ref: [:source_ref])
        builder.add_properties(
          :manager_ref        => manager_ref,
          :strategy           => :local_db_find_missing_references,
          :saver_strategy     => :concurrent_safe_batch,
          :retention_strategy => :archive
        )
      end

      def add_default_values(builder)
        builder.add_default_values(
          :source_id => ->(persister) { persister.manager.id },
          :tenant_id => ->(persister) { persister.manager.tenant_id },
        )
      end

      def add_secondary_refs_name(builder)
        builder.add_properties(:secondary_refs => {:by_name => [:name]})
      end

      def add_containers
        add_collection(:containers) do |builder|
          add_default_properties(builder, manager_ref: [:container_group, :name])
          builder.add_default_values(:tenant_id => ->(persister) { persister.manager.tenant_id })
        end
      end

      def add_cross_link_vms
        add_collection(:cross_link_vms) do |builder|
          builder.add_properties(
            :arel        => Vm.where(:tenant => manager.tenant),
            :association => nil,
            :model_class => Vm,
            :name        => :cross_link_vms,
            :manager_ref => [:uid_ems],
            :strategy    => :local_db_find_references,
          )
        end
      end

      def add_taggings
        add_collection(:taggings) do |builder|
          builder.add_properties(
            :manager_ref => [:taggable, :tag],
            :strategy           => :local_db_find_missing_references,
            :saver_strategy     => :concurrent_safe_batch,
          )
          add_default_values(builder)
        end
      end

      def add_tags
        add_collection(:tags) do |builder|
          builder.add_properties(
            :manager_ref => [:name],
            :strategy           => :local_db_find_missing_references,
            :saver_strategy     => :concurrent_safe_batch,
          )
          add_default_values(builder)
        end
      end
    end
  end
end
