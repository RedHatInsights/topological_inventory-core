class ExternalTenantMustBeUniqueAndNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tenants, :external_tenant, false
    add_index :tenants, [:external_tenant], :unique => true
  end
end
