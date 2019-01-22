class IndexForeignKeysInServiceInstances < ActiveRecord::Migration[5.2]
  def change
    add_index :service_instances, :tenant_id
  end
end
