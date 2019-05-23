class AddDatastoreMounts < ActiveRecord::Migration[5.2]
  def change
    create_table :datastore_mounts, :id => :bigserial, :force => :cascade do |t|
      t.references :datastore, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :host,      :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.boolean :read_only
      t.boolean :accessible

      t.datetime :last_seen_at

      t.index %i[host_id]
      t.index %i[last_seen_at]
      t.index %i[datastore_id host_id], :unique => true
    end
  end
end
