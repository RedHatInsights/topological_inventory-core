class AddHardwareAttributesToFlavors < ActiveRecord::Migration[5.1]
  def change
    add_column :flavors, :disk_size, :bigint
    add_column :flavors, :memory, :bigint
    add_column :flavors, :disk_count, :integer
    add_column :flavors, :cpus, :integer
  end
end
