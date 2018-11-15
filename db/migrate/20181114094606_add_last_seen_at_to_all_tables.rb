class AddLastSeenAtToAllTables < ActiveRecord::Migration[5.1]
  def change
    add_column :container_groups, :last_seen_at, :datetime
    add_index :container_groups, :last_seen_at

    add_column :container_nodes, :last_seen_at, :datetime
    add_index :container_nodes, :last_seen_at

    add_column :container_projects, :last_seen_at, :datetime
    add_index :container_projects, :last_seen_at

    add_column :container_templates, :last_seen_at, :datetime
    add_index :container_templates, :last_seen_at

    add_column :service_instances, :last_seen_at, :datetime
    add_index :service_instances, :last_seen_at

    add_column :service_offerings, :last_seen_at, :datetime
    add_index :service_offerings, :last_seen_at

    add_column :service_plans, :last_seen_at, :datetime
    add_index :service_plans, :last_seen_at

    add_column :source_regions, :last_seen_at, :datetime
    add_index :source_regions, :last_seen_at

    add_column :subscriptions, :last_seen_at, :datetime
    add_index :subscriptions, :last_seen_at

    add_column :vms, :last_seen_at, :datetime
    add_index :vms, :last_seen_at

    add_column :orchestration_stacks, :last_seen_at, :datetime
    add_index :orchestration_stacks, :last_seen_at
  end
end
