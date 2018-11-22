class AddRefreshStatesAndRefreshStateParts < ActiveRecord::Migration[5.1]
  def change
    create_table "refresh_states", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references "tenant", :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.uuid       "uuid", :null => false
      t.string     "status"
      t.integer    "total_parts"
      t.jsonb      "sweep_scope"
      t.integer    "sweep_retry_count", :default => 0
      t.string     "error_message"
      t.timestamps
      t.index      %i(source_id uuid), :unique => true
    end

    create_table "refresh_state_parts", :id => :bigserial do |t|
      t.references "refresh_state", :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references "tenant", :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.uuid       "uuid", :null => false
      t.string     "status"
      t.string     "error_message"
      t.timestamps
      t.index      %i(refresh_state_id uuid), :unique => true
    end
  end
end
