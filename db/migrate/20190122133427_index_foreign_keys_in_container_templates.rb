class IndexForeignKeysInContainerTemplates < ActiveRecord::Migration[5.2]
  def change
    add_index :container_templates, :tenant_id
  end
end
