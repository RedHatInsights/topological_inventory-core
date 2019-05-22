class AddDatastores < ActiveRecord::Migration[5.2]
  def change
    create_table :datastores, :id => :bigserial, :force => :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :name
      t.string :location
      t.bigint :total_space
      t.bigint :free_space
      t.string :status
      t.boolean :accessible
      t.jsonb :extra

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index %i[source_id source_ref], :unique => true
      t.index :archived_at
      t.index :last_seen_at
    end

    create_table :datastore_tags, :id => :serial, :force => :cascade do |t|
      t.references :tag,       :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :datastore, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[datastore_id]
      t.index %i[last_seen_at]
      t.index %i[tag_id datastore_id], :unique => true
    end
  end
end
