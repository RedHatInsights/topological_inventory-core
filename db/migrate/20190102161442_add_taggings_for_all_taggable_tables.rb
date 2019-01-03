class AddTaggingsForAllTaggableTables < ActiveRecord::Migration[5.1]
  def change
    create_table "tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "name", :null => false
      t.text "description"
      t.boolean "active", :default => true, :null => false

      # TODO what is human readable name? Will we use it for searching? How will we search with translated field?
      t.string "display_name"

      # TODO the queries like "starts_with" won't be consistent across platform, if we'll model separately vs. encoded
      # as namespace/name. Or we'll have to do query transformations, will we do that?
      t.string "namespace"

      # TODO how to model 'Whether this tag can accept zero, one, or multiple associated values', should be just
      # 'multiple' boolean and allow it only if there are values to be associated?
      t.boolean "multiple", :default => false, :null => false

      t.index ["tenant_id", "name", "namespace"],
              :name => "index_tags_on_tenant_id_name_and_namespace",
              :unique => true

      t.index ["tenant_id", "name"], :where  => "namespace IS NULL", :unique => true
    end

    create_table "tag_values", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false

      t.index ["tag_id", "value"], :unique => true
    end

    create_table "vms_tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      # TODO should we name the relation according to the table it relates to? Or just always taggable_id?
      t.references :vm, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      # TODO might be better to always have association to value? Where the value could be NULL or empty string? That
      # way we can make sure the value is always set. Otherwise we could have nil here, if the value is actually required.
      t.references :tag_value, :type => :bigint, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.index ["tag_id", "vm_id", "tag_value_id"], :unique => true
      t.index ["tag_id", "vm_id"], :where  => "tag_value_id IS NULL", :unique => true
    end

    # TODO add similar mapping tables for all other entities, containers_tags, container_images_tags, etc.
  end
end
