class AddTaggingsForAllTaggableTables < ActiveRecord::Migration[5.1]
  def change
    create_table "tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "name", :null => false
      t.text "description"

      t.boolean "active", :default => true, :null => false
      t.boolean "multiple", :default => false, :null => false

      t.index ["tenant_id", "name"], :unique => true
    end

    create_table "vm_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :vm, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["vm_id", "tag_id", "value"], :name => "uniq_index_on_vm_id_tag_id_and_value", :unique => true
    end

    create_table "container_group_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_group, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_group_id", "tag_id", "value"], :name => "uniq_index_on_container_group_id_tag_id_and_value", :unique => true
    end

    create_table "container_image_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_image, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_image_id", "tag_id", "value"], :name => "uniq_index_on_container_image_id_tag_id_and_value", :unique => true
    end

    create_table "container_node_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_node, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_node_id", "tag_id", "value"], :name => "uniq_index_on_container_node_id_tag_id_and_value", :unique => true
    end

    create_table "container_project_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_project, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_project_id", "tag_id", "value"], :name => "uniq_index_on_container_project_id_tag_id_and_value", :unique => true
    end

    create_table "container_template_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_template, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_template_id", "tag_id", "value"], :name => "uniq_index_on_container_template_id_tag_id_and_value", :unique => true
    end
  end
end
