class AddTimestampsForParallelSaving < ActiveRecord::Migration[5.1]
  def change
    add_column :container_groups,    :resource_timestamp, :datetime
    add_column :container_nodes,     :resource_timestamp, :datetime
    add_column :container_projects,  :resource_timestamp, :datetime
    add_column :container_templates, :resource_timestamp, :datetime
    add_column :service_instances,   :resource_timestamp, :datetime
    add_column :service_offerings,   :resource_timestamp, :datetime
    add_column :service_plans,       :resource_timestamp, :datetime

    add_column :container_groups,    :resource_timestamps, :jsonb, :default => {}
    add_column :container_nodes,     :resource_timestamps, :jsonb, :default => {}
    add_column :container_projects,  :resource_timestamps, :jsonb, :default => {}
    add_column :container_templates, :resource_timestamps, :jsonb, :default => {}
    add_column :service_instances,   :resource_timestamps, :jsonb, :default => {}
    add_column :service_offerings,   :resource_timestamps, :jsonb, :default => {}
    add_column :service_plans,       :resource_timestamps, :jsonb, :default => {}

    add_column :container_groups,    :resource_timestamps_max, :datetime
    add_column :container_nodes,     :resource_timestamps_max, :datetime
    add_column :container_projects,  :resource_timestamps_max, :datetime
    add_column :container_templates, :resource_timestamps_max, :datetime
    add_column :service_instances,   :resource_timestamps_max, :datetime
    add_column :service_offerings,   :resource_timestamps_max, :datetime
    add_column :service_plans,       :resource_timestamps_max, :datetime
  end
end
