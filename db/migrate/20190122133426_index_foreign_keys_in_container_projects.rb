class IndexForeignKeysInContainerProjects < ActiveRecord::Migration[5.2]
  def change
    add_index :container_projects, :tenant_id
  end
end
