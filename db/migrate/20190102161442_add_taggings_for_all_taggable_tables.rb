class AddTaggingsForAllTaggableTables < ActiveRecord::Migration[5.1]
  def change
    create_table "tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "name", :null => false
      t.text "description"

      # TODO maybe rather archived_at?
      t.boolean "active", :default => true, :null => false

      # TODO how to model 'Whether this tag can accept zero, one, or multiple associated values', should be just
      # 'multiple' boolean and allow it only if there are values to be associated?
      t.boolean "multiple", :default => false, :null => false

      t.index ["tenant_id", "name"], :unique => true
    end

    create_table "vms_tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''

      # TODO should we name the relation according to the table it relates to? Or just always taggable_id?
      t.references :vm, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["vm_id", "tag_id", "value"], :unique => true
    end

    # TODO add similar mapping tables for all other entities, containers_tags, container_images_tags, etc.
  end
end
