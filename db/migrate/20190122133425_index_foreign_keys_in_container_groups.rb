class IndexForeignKeysInContainerGroups < ActiveRecord::Migration[5.2]
  def change
    add_index :container_groups, :tenant_id
  end
end
