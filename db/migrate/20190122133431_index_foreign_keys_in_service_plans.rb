class IndexForeignKeysInServicePlans < ActiveRecord::Migration[5.2]
  def change
    add_index :service_plans, :tenant_id
  end
end
