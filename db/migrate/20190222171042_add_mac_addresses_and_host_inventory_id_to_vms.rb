class AddMacAddressesAndHostInventoryIdToVms < ActiveRecord::Migration[5.2]
  def change
    add_column :vms, :host_inventory_uuid, :uuid
    add_column :vms, :mac_addresses, :jsonb

    add_index :vms, :host_inventory_uuid
  end
end
