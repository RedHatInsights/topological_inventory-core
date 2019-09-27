class AddServiceInventoriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :service_inventories, :id => :bigserial, :force => :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :name
      t.text :description

      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, :default => {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_updated_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    create_table :service_inventories_tags, :id => :serial, :force => :cascade do |t|
      t.references :tag, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :service_inventory, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id service_inventory_id], :unique => true, :name => "service_inventories_tags_unique_index"
    end
  end
end
