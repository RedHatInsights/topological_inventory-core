class AddGuestInfoToVms < ActiveRecord::Migration[5.2]
  def change
    add_column :vms, :guest_info, :string
  end
end
