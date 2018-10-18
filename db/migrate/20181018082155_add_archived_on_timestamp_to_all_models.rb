class AddArchivedOnTimestampToAllModels < ActiveRecord::Migration[5.1]
  def change
    add_column :container_groups,        :archived_on, :datetime
    add_column :container_nodes,         :archived_on, :datetime
    add_column :container_projects,      :archived_on, :datetime
    add_column :container_templates,     :archived_on, :datetime
    add_column :service_instances,       :archived_on, :datetime
    add_column :service_offerings,       :archived_on, :datetime
    add_column :service_parameters_sets, :archived_on, :datetime

    add_index :container_groups,        :archived_on
    add_index :container_nodes,         :archived_on
    add_index :container_projects,      :archived_on
    add_index :container_templates,     :archived_on
    add_index :service_instances,       :archived_on
    add_index :service_offerings,       :archived_on
    add_index :service_parameters_sets, :archived_on
  end
end
