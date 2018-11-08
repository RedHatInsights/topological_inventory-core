class AddContainers < ActiveRecord::Migration[5.1]
  def change
    create_table :containers do |t|
      t.references :tenant,          :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :container_group, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :name

      t.float :cpu_limit
      t.float :cpu_request

      t.bigint :memory_limit
      t.bigint :memory_request

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :archived_on, :index => true
      t.index [:container_group_id, :name], :unique => true
    end
  end
end
