class AddTaggingsForAllTaggableTables < ActiveRecord::Migration[5.1]
  def change
    create_table "tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "name", :null => false
      t.text "description"

      t.boolean "active", :default => true, :null => false
      t.boolean "multiple", :default => false, :null => false

      t.index ["tenant_id", "name"], :unique => true
    end

    create_table "vms_tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :vm, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["vm_id", "tag_id", "value"], :name => "uniq_index_on_vm_id_tag_id_and_value", :unique => true
    end

    create_table "container_groups_tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      t.references :container_group, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["container_group_id", "tag_id", "value"], :name => "uniq_index_on_container_group_id_tag_id_and_value", :unique => true
    end

    # TODO add similar mapping tables for all other entities, containers_tags, container_images_tags, etc.
  end
end
