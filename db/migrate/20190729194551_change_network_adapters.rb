class ChangeNetworkAdapters < ActiveRecord::Migration[5.2]
  def change
    add_reference :network_adapters, :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
    add_reference :network_adapters, :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

    # Relations to VMs, Hosts, etc.
    add_reference :network_adapters, :device, :index => true, :polymorphic => true, :null => true
    add_index :network_adapters,
              %i(source_id source_ref),
              :unique => true

    remove_column :network_adapters, :ipaddresses, :jsonb

    # Drop old mapping tables
    drop_table :vm_network_adapters do |t|
      t.references :vm, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network_adapter, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.datetime :last_seen_at
      t.index :last_seen_at
    end

    drop_table :host_network_adapters do |t|
      t.references :host, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network_adapter, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.datetime :last_seen_at
      t.index :last_seen_at
    end
  end
end
