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

    create_table "vms_tags", id: :serial, force: :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      # TODO should we support both NULL and empty string? We could just default to empty string and we can have only
      # 1 unique index. Also graph refresh won't probably allow to store both "" and NULL combination
      t.string "value"

      # TODO should we name the relation according to the table it relates to? Or just always taggable_id?
      t.references :vm, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["tag_id", "vm_id", "value"], :unique => true
      t.index ["tag_id", "vm_id"], :where  => "value IS NULL", :unique => true
    end

    # TODO add similar mapping tables for all other entities, containers_tags, container_images_tags, etc.
  end
end
