class AddNetworkAdapters < ActiveRecord::Migration[5.2]
  def change
    create_table :network_adapters do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :mac_address
      t.jsonb :ipaddresses
      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb    :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at
    end

    create_table :vm_network_adapters do |t|
      t.references :vm,              :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network_adapter, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.datetime   :last_seen_at
      t.index      :last_seen_at
    end

    create_table :host_network_adapters do |t|
      t.references :host,            :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network_adapter, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.datetime   :last_seen_at
      t.index      :last_seen_at
    end
  end
end
