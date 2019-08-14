class AddSourceCollectorStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :refresh_status, :string
  end
end
