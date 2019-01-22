class RemoveExtraneousIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :service_offerings, :source_id
    remove_index :subscriptions, :source_id
    remove_index :source_regions, :source_id
    remove_index :vms, :source_id
    remove_index :flavors, :source_id
    remove_index :orchestration_stacks, :source_id
    remove_index :container_groups, :source_id
    remove_index :container_images, :source_id
    remove_index :container_nodes, :source_id
    remove_index :container_projects, :source_id
    remove_index :service_instances, :source_id
    remove_index :service_plans, :source_id
    remove_index :container_templates, :source_id
  end
end
