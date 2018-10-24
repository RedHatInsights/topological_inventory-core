require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Default < InventoryRefresh::Persister
      def initialize_inventory_collections
        add_collection(:container_groups)
        add_collection(:container_nodes)    { |b| add_secondary_refs_name(b) }
        add_collection(:container_projects) { |b| add_secondary_refs_name(b) }
        add_collection(:container_templates)
        add_collection(:service_instances)
        add_collection(:service_offerings)
        add_collection(:service_plans)
      end

      def targeted?
        true
      end

      private

      def add_collection(model)
        super do |builder|
          add_default_properties(builder)
          yield builder if block_given?
        end
      end

      def add_default_properties(builder)
        builder.add_properties(
          :manager_ref        => [:source_ref],
          :strategy           => :local_db_find_missing_references,
          :saver_strategy     => :concurrent_safe_batch,
          :retention_strategy => :archive
        )

        builder.add_default_values(
          :source_id => ->(persister) { persister.manager.id },
          :tenant_id => ->(persister) { persister.manager.tenant_id },
        )
      end

      def add_secondary_refs_name(builder)
        builder.add_properties(:secondary_refs => {:by_name => [:name]})
      end
    end
  end
end
