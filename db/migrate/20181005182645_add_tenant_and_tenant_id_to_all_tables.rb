class AddTenantAndTenantIdToAllTables < ActiveRecord::Migration[5.0]
  def change
    create_table "tenants", id: :bigserial, force: :cascade do |t|
      t.string   "name"
      t.text     "description"
      t.string   "external_tenant"
      t.timestamps
    end
    
    add_column    :authentications,         :tenant_id, :bigint
    add_column    :container_groups,        :tenant_id, :bigint
    add_column    :container_projects,      :tenant_id, :bigint
    add_column    :container_templates,     :tenant_id, :bigint
    add_column    :endpoints,               :tenant_id, :bigint
    add_column    :service_instances,       :tenant_id, :bigint
    add_column    :service_offerings,       :tenant_id, :bigint
    add_column    :service_parameters_sets, :tenant_id, :bigint
    add_column    :sources,                 :tenant_id, :bigint
  end
end
