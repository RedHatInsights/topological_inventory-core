class AddIndexToRefreshState < ActiveRecord::Migration[5.2]
  def change
    add_index :refresh_states, :updated_at
  end
end
