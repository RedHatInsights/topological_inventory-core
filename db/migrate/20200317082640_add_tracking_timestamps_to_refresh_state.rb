class AddTrackingTimestampsToRefreshState < ActiveRecord::Migration[5.2]
  def change
    add_column :refresh_states, :started_at, :timestamp
    add_column :refresh_states, :finished_at, :timestamp
  end
end
