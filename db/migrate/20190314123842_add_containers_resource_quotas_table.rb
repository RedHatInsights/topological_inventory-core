class AddContainersResourceQuotasTable < ActiveRecord::Migration[5.2]
  def change
    create_table :container_resource_quotas, :id => :bigserial do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.references :container_project, :type => :bigint, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :resource_version
      t.string :name
      t.jsonb  :status
      t.jsonb  :spec

      t.timestamps
      t.datetime   :archived_at
      t.datetime   :last_seen_at
      t.datetime   :source_deleted_at
      t.datetime   :source_created_at

      t.datetime   :resource_timestamp
      t.jsonb      :resource_timestamps, :default => {}
      t.datetime   :resource_timestamps_max

      t.index [:source_id, :source_ref], :unique => true
      t.index :archived_at
      t.index :last_seen_at
    end
  end
end
