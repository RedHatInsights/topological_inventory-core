class AddUniqueIndexesToTagMappingTables < ActiveRecord::Migration[5.2]
  def change
    add_index :container_group_tags, [:container_group_id, :tag_id],
              :name => "uniq_index_on_container_group_id_tag_id", :unique => true
    add_index :container_image_tags, [:container_image_id, :tag_id],
              :name => "uniq_index_on_container_image_id_tag_id", :unique => true
    add_index :container_node_tags, [:container_node_id, :tag_id],
              :name => "uniq_index_on_container_node_id_tag_id", :unique => true
    add_index :container_project_tags, [:container_project_id, :tag_id],
              :name => "uniq_index_on_container_project_id_tag_id", :unique => true
    add_index :container_template_tags, [:container_template_id, :tag_id],
              :name => "uniq_index_on_container_template_id_tag_id", :unique => true
    add_index :service_offering_tags, [:service_offering_id, :tag_id],
              :name => "uniq_index_on_service_offering_id_tag_id", :unique => true
    add_index :vm_tags, [:vm_id, :tag_id],
              :name => "uniq_index_on_vm_id_tag_id", :unique => true

    remove_index :tags, :column => ["tenant_id", "namespace", "name"], :unique => true
    add_index :tags, ["tenant_id", "namespace", "name", "value"], :unique => true
  end
end
