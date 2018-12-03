class RenameArchivedOn < ActiveRecord::Migration[5.1]
  def change
    rename_column :container_groups,     :archived_on, :archived_at
    rename_column :container_images,     :archived_on, :archived_at
    rename_column :container_nodes,      :archived_on, :archived_at
    rename_column :container_projects,   :archived_on, :archived_at
    rename_column :container_templates,  :archived_on, :archived_at
    rename_column :containers,           :archived_on, :archived_at
    rename_column :flavors,              :archived_on, :archived_at
    rename_column :orchestration_stacks, :archived_on, :archived_at
    rename_column :service_instances,    :archived_on, :archived_at
    rename_column :service_offerings,    :archived_on, :archived_at
    rename_column :service_plans,        :archived_on, :archived_at
    rename_column :source_regions,       :archived_on, :archived_at
    rename_column :subscriptions,        :archived_on, :archived_at
    rename_column :vms,                  :archived_on, :archived_at
  end
end
