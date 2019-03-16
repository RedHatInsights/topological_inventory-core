class AddColumnsForContainersCapacityPlanningAnalytics < ActiveRecord::Migration[5.2]
  def change
    add_column :container_projects, :status_phase, :string

    add_column :container_nodes, :pods, :integer
    add_column :container_nodes, :allocatable_memory, :bigint
    add_column :container_nodes, :allocatable_cpus, :float
    add_column :container_nodes, :allocatable_pods, :integer
    add_column :container_nodes, :conditions, :jsonb
    add_column :container_nodes, :addresses, :jsonb
    add_column :container_nodes, :node_info, :jsonb
  end
end
