class MoveTagValueToTags < ActiveRecord::Migration[5.2]
  def up
    add_column :tags, :value, :string, :null => false, :default => ""

    remove_column :container_group_tags,    :value
    remove_column :container_image_tags,    :value
    remove_column :container_node_tags,     :value
    remove_column :container_project_tags,  :value
    remove_column :container_template_tags, :value
    remove_column :service_offering_tags,   :value
    remove_column :vm_tags,                 :value
  end

  def down
    remove_column :tags, :value

    add_column :container_group_tags,    :value, :string, :default => "", :null => false
    add_column :container_image_tags,    :value, :string, :default => "", :null => false
    add_column :container_node_tags,     :value, :string, :default => "", :null => false
    add_column :container_project_tags,  :value, :string, :default => "", :null => false
    add_column :container_template_tags, :value, :string, :default => "", :null => false
    add_column :service_offering_tags,   :value, :string, :default => "", :null => false
    add_column :vm_tags,                 :value, :string, :default => "", :null => false

    add_index :container_group_tags, [:container_group_id, :tag_id, :value],
              :name => "uniq_index_on_container_group_id_tag_id_and_value", :unique => true
    add_index :container_image_tags, [:container_image_id, :tag_id, :value],
              :name => "uniq_index_on_container_image_id_tag_id_and_value", :unique => true
    add_index :container_node_tags, [:container_node_id, :tag_id, :value],
              :name => "uniq_index_on_container_node_id_tag_id_and_value", :unique => true
    add_index :container_project_tags, [:container_project_id, :tag_id, :value],
              :name => "uniq_index_on_container_project_id_tag_id_and_value", :unique => true
    add_index :container_template_tags, [:container_template_id, :tag_id, :value],
              :name => "uniq_index_on_container_template_id_tag_id_and_value", :unique => true
    add_index :service_offering_tags, [:service_offering_id, :tag_id, :value],
              :name => "uniq_index_on_service_offering_id_tag_id_and_value", :unique => true
    add_index :vm_tags, [:vm_id, :tag_id, :value],
              :name => "uniq_index_on_vm_id_tag_id_and_value", :unique => true
  end
end
