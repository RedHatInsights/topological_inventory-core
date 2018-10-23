class AddNotNullConstraintsToAllModels < ActiveRecord::Migration[5.1]
  def up
    change_column :container_groups,    :source_id, :bigint, :null => false
    change_column :container_nodes,     :source_id, :bigint, :null => false
    change_column :container_projects,  :source_id, :bigint, :null => false
    change_column :container_templates, :source_id, :bigint, :null => false
    change_column :service_instances,   :source_id, :bigint, :null => false
    change_column :service_offerings,   :source_id, :bigint, :null => false
    change_column :service_plans,       :source_id, :bigint, :null => false

    change_column :container_groups,    :tenant_id, :bigint, :null => false
    change_column :container_nodes,     :tenant_id, :bigint, :null => false
    change_column :container_projects,  :tenant_id, :bigint, :null => false
    change_column :container_templates, :tenant_id, :bigint, :null => false
    change_column :service_instances,   :tenant_id, :bigint, :null => false
    change_column :service_offerings,   :tenant_id, :bigint, :null => false
    change_column :service_plans,       :tenant_id, :bigint, :null => false
    change_column :endpoints,           :tenant_id, :bigint, :null => false
    change_column :sources,             :tenant_id, :bigint, :null => false
    change_column :authentications,     :tenant_id, :bigint, :null => false
  end
  
  def down
    change_column :container_groups,    :source_id, :bigint, :null => true
    change_column :container_nodes,     :source_id, :bigint, :null => true
    change_column :container_projects,  :source_id, :bigint, :null => true
    change_column :container_templates, :source_id, :bigint, :null => true
    change_column :service_instances,   :source_id, :bigint, :null => true
    change_column :service_offerings,   :source_id, :bigint, :null => true
    change_column :service_plans,       :source_id, :bigint, :null => true

    change_column :container_groups,    :tenant_id, :bigint, :null => true
    change_column :container_nodes,     :tenant_id, :bigint, :null => true
    change_column :container_projects,  :tenant_id, :bigint, :null => true
    change_column :container_templates, :tenant_id, :bigint, :null => true
    change_column :service_instances,   :tenant_id, :bigint, :null => true
    change_column :service_offerings,   :tenant_id, :bigint, :null => true
    change_column :service_plans,       :tenant_id, :bigint, :null => true
    change_column :endpoints,           :tenant_id, :bigint, :null => true
    change_column :sources,             :tenant_id, :bigint, :null => true
    change_column :authentications,     :tenant_id, :bigint, :null => true
  end
end
