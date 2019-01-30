class AddMissingNotNullConstraintsToSourceRef < ActiveRecord::Migration[5.2]
  def change
    change_column_null :container_images, :source_ref, false
    change_column_null :orchestration_stacks, :source_ref, false
    change_column_null :flavors, :source_ref, false
    change_column_null :vms, :source_ref, false
    change_column_null :volume_types, :source_ref, false
    change_column_null :container_groups, :source_ref, false
    change_column_null :container_projects, :source_ref, false
    change_column_null :container_templates, :source_ref, false
    change_column_null :source_regions, :source_ref, false
    change_column_null :service_instances, :source_ref, false
    change_column_null :service_plans, :source_ref, false
    change_column_null :service_offerings, :source_ref, false
    change_column_null :volumes, :source_ref, false
    change_column_null :container_nodes, :source_ref, false
    change_column_null :subscriptions, :source_ref, false

    change_column_null :containers, :name, false
  end
end
