class AddIndexToRefreshStateParts < ActiveRecord::Migration[5.2]
  def change
    add_index :refresh_state_parts, :uuid
    add_index :refresh_states, :uuid
  end
end
