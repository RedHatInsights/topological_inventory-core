class AddClusters < ActiveRecord::Migration[5.2]
  def change
    create_table "clusters", id: :bigserial, force: :cascade do |t|
      t.references :tenant, :index => true,  :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :uid_ems
      t.string :name
      t.jsonb  :extra

      t.datetime :resource_timestamp
      t.jsonb    :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index %i[source_id source_ref], :unique => true
      t.index :archived_at
      t.index :last_seen_at
      t.index :uid_ems
    end

    create_table :cluster_tags, id: :serial, force: :cascade do |t|
      t.references :tag,     :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :cluster, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[cluster_id]
      t.index %i[last_seen_at]
      t.index %i[tag_id cluster_id], unique: true
    end
  end
end
