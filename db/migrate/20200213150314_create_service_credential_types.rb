class CreateServiceCredentialTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :service_credential_types do |t|
      t.string :name
      t.string :description
      t.string :kind
      t.string :namespace

      t.string :source_ref, :null => false

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, :default => {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true

      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
    end
  end
end
