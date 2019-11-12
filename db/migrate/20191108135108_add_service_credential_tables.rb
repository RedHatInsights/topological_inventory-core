class AddServiceCredentialTables < ActiveRecord::Migration[5.2]
  def change
    create_table :service_credentials, :id => :bigserial, :force => :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => { :on_delete => :cascade }
      t.references :source, :index => false, :null => false, :foreign_key => { :on_delete => :cascade }

      t.string :source_ref, :null => false
      t.string :name
      t.string :type_name
      t.text :description

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, :default => {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_updated_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    add_reference :service_offerings, :service_credential, :index => true, :null => true, :foreign_key => { :on_delete => :nullify }
    add_reference :service_instances, :service_credential, :index => true, :null => true, :foreign_key => { :on_delete => :nullify }
    add_reference :service_offering_nodes, :service_credential, :index => true, :null => true, :foreign_key => { :on_delete => :nullify }
    add_reference :service_instance_nodes, :service_credential, :index => true, :null => true, :foreign_key => { :on_delete => :nullify }
  end
end
