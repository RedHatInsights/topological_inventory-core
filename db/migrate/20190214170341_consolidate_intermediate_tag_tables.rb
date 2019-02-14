class ConsolidateIntermediateTagTables < ActiveRecord::Migration[5.2]
  def up
    create_table :taggings do |t|
      t.references :tenant,   :null => false, :index => true
      t.references :resource, :null => false, :index => true, :polymorphic => true
      t.references :tag,      :null => false, :index => true
      t.string     :value
      t.timestamps
    end

    drop_table :container_group_tags
    drop_table :container_image_tags
    drop_table :container_node_tags
    drop_table :container_project_tags
    drop_table :container_template_tags
    drop_table :service_offering_tags
    drop_table :vm_tags
  end

  def down
    drop_table :taggings
  end
end
