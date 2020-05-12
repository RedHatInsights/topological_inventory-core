class AddSourceUpdatedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :volumes, :source_updated_at, :timestamp
  end
end
