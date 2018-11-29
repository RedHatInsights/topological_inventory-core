require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Default < InventoryRefresh::Persister
      def initialize_inventory_collections
        add_containers
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
        add_cross_link_vms
        add_tags
      end

      def targeted?
        true
      end

      private

      def add_default_collection(model)
        add_collection(model, InventoryRefresh::InventoryCollection::Builder, :attributes_blacklist => [:tags]) do |builder|
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

      def add_tags
        builder_klass    = InventoryRefresh::InventoryCollection::Builder
        extra_properties = {}
        settings         = {
          :without_model_class       => true,
          :auto_inventory_attributes => false,
          :association               => nil,
        }

        add_collection(:tags, builder_klass, extra_properties, settings) do |builder|
          builder.add_dependency_attributes(
            :service_offerings => [collections[:service_offerings]],
          )
          builder.add_properties(
            :custom_save_block => lambda do |_source, inventory_collection|
              inventory_collection.dependency_attributes.each_value do |collections|
                inventory_collection = collections.first

                inventory_objects_index = inventory_collection.data.index_by(&:id)
                inventory_collection.model_class.find(inventory_collection.data.map(&:id)).each do |record|
                  tags = inventory_objects_index[record.id][:tags]
                  next if tags.nil?

                  record.tag_list = tags.join(",")
                  record.save!
                end
              end
            end
          )
        end
      end
    end
  end
end
