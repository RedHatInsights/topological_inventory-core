class AddSourceCreatedAndDeletedAtTimestamps < ActiveRecord::Migration[5.1]
  def change
    add_column :container_groups,        :source_created_at, :datetime
    add_column :container_nodes,         :source_created_at, :datetime
    add_column :container_projects,      :source_created_at, :datetime
    add_column :container_templates,     :source_created_at, :datetime
    add_column :service_instances,       :source_created_at, :datetime
    add_column :service_offerings,       :source_created_at, :datetime
    add_column :service_parameters_sets, :source_created_at, :datetime

    rename_column :container_groups,        :deleted_at, :source_deleted_at
    rename_column :container_nodes,         :deleted_at, :source_deleted_at
    rename_column :container_projects,      :deleted_at, :source_deleted_at
    rename_column :container_templates,     :deleted_at, :source_deleted_at
    rename_column :service_instances,       :deleted_at, :source_deleted_at
    rename_column :service_offerings,       :deleted_at, :source_deleted_at
    rename_column :service_parameters_sets, :deleted_at, :source_deleted_at
  end
end
