class RemoveExtraColumnsFromTaggingJoinTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :container_group_tags, :created_at, :datetime
    remove_column :container_image_tags, :created_at, :datetime
    remove_column :container_node_tags, :created_at, :datetime
    remove_column :container_project_tags, :created_at, :datetime
    remove_column :container_template_tags, :created_at, :datetime
    remove_column :service_offering_tags, :created_at, :datetime
    remove_column :vm_tags, :created_at, :datetime

    remove_reference :container_group_tags, :tenant, :index => true, :null => false,  :foreign_key => {:on_delete => :cascade}
    remove_reference :container_image_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_node_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_project_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_template_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
    remove_reference :service_offering_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
    remove_reference :vm_tags, :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
  end
end
