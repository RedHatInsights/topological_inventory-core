require "topological_inventory/schema/base"

module TopologicalInventory
  module Schema
    class Default < TopologicalInventory::Schema::Base
      def initialize_inventory_collections
        add_default_collection(:clusters)
        add_containers
        add_default_collection(:container_groups)
        add_default_collection(:container_images)
        add_default_collection(:container_nodes) { |b| add_secondary_refs_name(b) }
        add_default_collection(:container_projects) { |b| add_secondary_refs_name(b) }
        add_default_collection(:container_resource_quotas)
        add_default_collection(:container_templates)
        add_default_collection(:datastores)
        add_default_collection(:flavors)
        add_default_collection(:ipaddresses)
        add_default_collection(:hosts)
        add_default_collection(:network_adapters)
        add_default_collection(:networks)
        add_default_collection(:orchestration_stacks)
        add_default_collection(:reservations)
        add_default_collection(:service_instances)
        add_default_collection(:service_instance_nodes)
        add_default_collection(:service_inventories)
        add_default_collection(:security_groups)
        add_default_collection(:service_offering_icons)
        add_default_collection(:service_offerings)
        add_default_collection(:service_offering_nodes)
        add_default_collection(:service_credentials)
        add_default_collection(:service_credential_types)
        add_default_collection(:service_plans)
        add_default_collection(:source_regions)
        add_default_collection(:subnets)
        add_default_collection(:subscriptions)
        add_default_collection(:vms)
        add_default_collection(:volumes)
        add_default_collection(:volume_types)

        add_collection_for_join_table(:service_offering_service_credentials, :manager_ref => %i[service_offering service_credential])
        add_collection_for_join_table(:service_instance_service_credentials, :manager_ref => %i[service_instance service_credential])
        add_collection_for_join_table(:service_offering_node_service_credentials, :manager_ref => %i[service_offering_node service_credential])
        add_collection_for_join_table(:service_instance_node_service_credentials, :manager_ref => %i[service_instance_node service_credential])

        add_tagging_collection(:cluster_tags, :manager_ref => %i[cluster tag])
        add_tagging_collection(:container_group_tags, :manager_ref => [:container_group, :tag])
        add_tagging_collection(:container_image_tags, :manager_ref => [:container_image, :tag])
        add_tagging_collection(:container_node_tags, :manager_ref => [:container_node, :tag])
        add_tagging_collection(:container_project_tags, :manager_ref => [:container_project, :tag])
        add_tagging_collection(:container_template_tags, :manager_ref => [:container_template, :tag])
        add_tagging_collection(:datastore_tags, :manager_ref => [:datastore, :tag])
        add_tagging_collection(:ipaddress_tags, :manager_ref => [:ipaddress, :tag])
        add_tagging_collection(:host_tags, :manager_ref => %i[host tag])
        add_tagging_collection(:network_adapter_tags, :manager_ref => [:network_adapter, :tag])
        add_tagging_collection(:network_tags, :manager_ref => [:network, :tag])
        add_tagging_collection(:reservation_tags, :manager_ref => [:reservation, :tag])
        add_tagging_collection(:security_group_tags, :manager_ref => [:security_group, :tag])
        add_tagging_collection(:service_inventory_tags, :manager_ref => [:service_inventory, :tag])
        add_tagging_collection(:service_offering_tags, :manager_ref => [:service_offering, :tag])
        add_tagging_collection(:subnet_tags, :manager_ref => [:subnet, :tag])
        add_tagging_collection(:vm_tags, :manager_ref => [:vm, :tag])
        add_tags

        add_datastore_mounts
        add_volume_attachments
        add_cross_link_vms
        add_vm_security_groups
        add_service_instance_tasks
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

      def add_collection_for_join_table(model, manager_ref: [:source_ref])
        add_collection(model) do |builder|
          builder.add_default_values(:tenant_id => ->(persister) { persister.manager.tenant_id })
          builder.add_properties(
            :manager_ref        => manager_ref,
            :strategy           => :local_db_find_missing_references,
            :retention_strategy => :destroy
          )
        end
      end

      def add_tagging_collection(model, manager_ref: [:source_ref])
        # TODO generate the manager_ref automatically?
        add_collection(model) do |builder|
          builder.add_default_values(:tenant_id => ->(persister) { persister.manager.tenant_id })
          builder.add_properties(
            :manager_ref        => manager_ref,
            :strategy           => :local_db_find_missing_references,
            :retention_strategy => :destroy,
          )
        end
      end

      def add_service_instance_tasks
        add_collection(:service_instance_tasks, inventory_collection_builder, {}, {:without_model_class => true}) do |builder|
          add_default_properties(builder)
          add_default_values(builder)

          builder.add_dependency_attributes(
            :service_instances => ->(persister) { [persister.collections[:service_instances]] }
          )

          save_block = lambda do |source, tasks_collection|
            service_instance_tasks_custom_save(source, tasks_collection)
          end

          builder.add_properties(:custom_save_block => save_block)
        end
      end

      def service_instance_tasks_custom_save(source, tasks_collection)
        service_instance_collection = tasks_collection.dependency_attributes[:service_instances]&.first
        src_refs = service_instance_collection&.data.to_a.collect { |inventory_object| inventory_object.source_ref }
        return if src_refs.blank?

        # Updating Tasks
        # service_instance_tasks_update_by_raw_sql(source)
        service_instance_tasks_update_by_activerecord(tasks_collection, source, src_refs)
      end

      def task_update_values(svc_instance_id, source_ref, external_url, status, artifacts, task_status, finished_timestamp, archived_timestamp, source_id)
        {
          :state   => finished_timestamp.blank? && archived_timestamp.blank? ? 'running' : 'completed',
          :status  => task_status,
          :context => {
            :service_instance => {
              :id         => svc_instance_id,
              :job_status => status,
              :artifacts  => artifacts,
              :source_id  => source_id,
              :source_ref => source_ref,
              :url        => external_url
            }
          }
        }
      end

      # This method is updating one by one using ActiveRecord
      def service_instance_tasks_update_by_activerecord(tasks_collection, source, svc_instances_source_ref)
        service_instances = ServiceInstance.where(:source_id => source.id, :source_ref => svc_instances_source_ref)
        tasks_by_source_ref = Task.where(:state => 'running', :target_type => 'ServiceInstance', :source_id => source.id, :target_source_ref => service_instances.pluck(:source_ref)).index_by(&:target_source_ref)

        service_instances.select(:id, :archived_at, :external_url, :source_ref, :extra).find_in_batches do |group|
          ActiveRecord::Base.transaction do
            group.each do |svc_instance|
              next if (task = tasks_by_source_ref[svc_instance.source_ref]).nil?

              values = task_update_values(svc_instance.id, svc_instance.source_ref, svc_instance.external_url, svc_instance.extra['status'], svc_instance.extra['artifacts'], svc_instance.extra['task_status'], svc_instance.extra['finished'], svc_instance.archived_at, source.id)
              # 1) Updating Task
              task.update(values)

              # 2) Saving to updated records (will be published in Kafka)
              # - see topological_inventory-persister:Workflow.send_task_updates_to_queue!
              tasks_collection.updated_records << values.merge(:id => task.id, :forwardable_headers => task.forwardable_headers)
            end
          end
        end
      end

      # This method is bulk updating by raw SQL query
      def service_instance_tasks_update_by_raw_sql(source)
        # Get running tasks
        tasks_source_ref = Task.where(:state => 'running', :target_type => 'ServiceInstance', :source_id => source.id)
                         .pluck(:target_source_ref)
        return if tasks_source_ref.blank?

        # Load saved service instances (IDs needed)
        svc_instances_values = ServiceInstance.where(:source_ref => tasks_source_ref)
                                              .pluck(:id, :archived_at, :external_url, :source_ref,
                                                     Arel.sql("extra->'finished'"),
                                                     Arel.sql("extra->'status'"),
                                                     Arel.sql("extra->'task_status'"),
                                                     Arel.sql("extra->'artifacts'"))
        return if svc_instances_values.blank?

        sql_update_values = []

        # Preparing SQL update values from loaded ServiceInstances
        svc_instances_values.each do |attrs|
          id, archived_at, external_url, source_ref, finished_timestamp, status, task_status, artifacts = attrs[0], attrs[1], attrs[2], attrs[3], attrs[4], attrs[5], attrs[6], attrs[7]

          values = task_update_values(id, source_ref, external_url, status, artifacts, task_status, finished_timestamp, archived_at, source.id)
          sql_update_values << "('#{source_ref}', '#{values[:state]}', '#{values[:status]}', '#{values[:context].to_json}'::json)"
        end

        # Update query.
        # Pairs records by `Task.target_type` and `Task.target_source_ref`
        sql = <<SQL
              UPDATE tasks AS t SET
                state = c.state,
                status = c.status,
                context = c.context
              FROM (VALUES :values
              ) AS c(source_ref, state, status, context)
              WHERE t.target_source_ref = c.source_ref
                AND t.target_type = 'ServiceInstance';
SQL
        sql.sub!(':values', sql_update_values.join(','))

        ActiveRecord::Base.connection.execute(sql)
      end

      def add_vm_security_groups
        add_collection(:vm_security_groups) do |builder|
          add_default_properties(builder, manager_ref: [:vm, :security_group])
          builder.add_properties(:retention_strategy => :destroy)
        end
      end

      def add_containers
        add_collection(:containers) do |builder|
          add_default_properties(builder, manager_ref: [:container_group, :name])
          builder.add_default_values(:tenant_id => ->(persister) { persister.manager.tenant_id })
        end
      end

      def add_volume_attachments
        add_collection(:volume_attachments) do |builder|
          add_default_properties(builder, manager_ref: [:volume, :vm])
          builder.add_properties(:retention_strategy => :destroy)
          builder.add_default_values(:tenant_id => ->(persister) { persister.manager.tenant_id })
        end
      end

      def add_datastore_mounts
        add_collection(:datastore_mounts) do |builder|
          add_default_properties(builder, manager_ref: [:datastore, :host])
          builder.add_properties(:retention_strategy => :destroy)
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
        add_collection(:tags) do |builder|
          builder.add_properties(
            :arel           => Tag.where(:tenant => manager.tenant),
            :association    => nil,
            :model_class    => Tag,
            :name           => :tags,
            :manager_ref    => [:name, :value, :namespace],
            :create_only    => true,
            :strategy       => :local_db_find_missing_references,
          )

          builder.add_default_values(
            :tenant_id => ->(persister) { persister.manager.tenant_id },
          )
        end
      end
    end
  end
end
