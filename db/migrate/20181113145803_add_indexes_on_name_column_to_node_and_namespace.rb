class AddIndexesOnNameColumnToNodeAndNamespace < ActiveRecord::Migration[5.1]
  def change
    add_index :container_nodes, :name
    add_index :container_projects, :name
  end
end
