class ChangeNetworkAdapters < ActiveRecord::Migration[5.2]
  def change
    add_reference :network_adapters, :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
    add_reference :network_adapters, :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

    # Relations to VMs, Hosts, etc.
    add_reference :network_adapters, :device, :index => true, :polymorphic => true, :null => true
    add_index :network_adapters,
              %i(source_id source_ref device_id device_type),
              :unique => true,
              :name   => "unique_index_network_adapters_with_device_id_and_type"
    add_index :network_adapters,
              %i(source_id source_ref),
              :where  => "device_id IS NULL AND device_type IS NULL",
              :unique => true,
              :name   => "unique_index_network_adapters"

    # # Alternative solution
    # add_reference :network_adapters, :vm, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
    # add_reference :network_adapters, :host, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
    #
    # add_index :network_adapters,
    #           %i(source_id source_ref host_id),
    #           :where  => "vm_id IS NULL",
    #           :unique => true,
    #           :name   => "unique_index_network_adapters_on_host_id"
    #
    # add_index :network_adapters,
    #           %i(source_id source_ref vm_id),
    #           :where  => "host_id IS NULL",
    #           :unique => true,
    #           :name   => "unique_index_network_adapters_on_vm_id"
    #
    # add_index :network_adapters,
    #           %i(source_id source_ref vm_id host_id),
    #           :unique => true,
    #           :name   => "unique_index_network_adapters_on_vm_id_and_host_id"

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
