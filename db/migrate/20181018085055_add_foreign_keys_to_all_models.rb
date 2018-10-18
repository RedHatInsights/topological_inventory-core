class AddForeignKeysToAllModels < ActiveRecord::Migration[5.1]
  def change
    # On cascade delete
    add_foreign_key :container_groups,        :sources, on_delete: :cascade
    add_foreign_key :container_nodes,         :sources, on_delete: :cascade
    add_foreign_key :container_projects,      :sources, on_delete: :cascade
    add_foreign_key :container_templates,     :sources, on_delete: :cascade
    add_foreign_key :service_instances,       :sources, on_delete: :cascade
    add_foreign_key :service_offerings,       :sources, on_delete: :cascade
    add_foreign_key :service_parameters_sets, :sources, on_delete: :cascade
    add_foreign_key :endpoints, :sources, on_delete: :cascade

    add_foreign_key :container_groups,        :tenants, on_delete: :cascade
    add_foreign_key :container_nodes,         :tenants, on_delete: :cascade
    add_foreign_key :container_projects,      :tenants, on_delete: :cascade
    add_foreign_key :container_templates,     :tenants, on_delete: :cascade
    add_foreign_key :service_instances,       :tenants, on_delete: :cascade
    add_foreign_key :service_offerings,       :tenants, on_delete: :cascade
    add_foreign_key :service_parameters_sets, :tenants, on_delete: :cascade
    add_foreign_key :endpoints, :tenants, on_delete: :cascade

    add_foreign_key :container_groups,    :container_projects, on_delete: :cascade
    add_foreign_key :container_templates, :container_projects, on_delete: :cascade

    add_foreign_key :container_groups, :container_nodes, on_delete: :cascade

    add_foreign_key :sources, :tenants, on_delete: :cascade

    add_foreign_key :authentications, :tenants, on_delete: :cascade

    add_foreign_key :service_parameters_sets, :service_offerings, on_delete: :cascade

    # On cascade nullify
    add_foreign_key :service_instances, :service_offerings, on_delete: :nullify
    add_foreign_key :service_instances, :service_parameters_sets, on_delete: :nullify
  end
end
