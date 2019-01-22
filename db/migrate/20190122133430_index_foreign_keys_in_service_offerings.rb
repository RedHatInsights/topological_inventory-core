class IndexForeignKeysInServiceOfferings < ActiveRecord::Migration[5.2]
  def change
    add_index :service_offerings, :tenant_id
  end
end
