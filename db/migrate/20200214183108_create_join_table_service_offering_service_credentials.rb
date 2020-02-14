class CreateJoinTableServiceOfferingServiceCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :service_offering_service_credentials do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :service_credential, :null => false, :index => false, :foreign_key => {:on_delete => :cascade}
      t.references :service_offering, :null => false, :index => false, :foreign_key => {:on_delete => :cascade}

      t.timestamps

      t.datetime :last_seen_at

      t.index %i[service_credential_id], :name => :index_service_offering_credentials_on_service_credential_id
      t.index %i[service_offering_id], :name => :index_service_offering_credentials_on_service_offering_id
      t.index %i[last_seen_at]
      t.index %i[service_credential_id service_offering_id], :unique => true, :name => :index_service_offering_credential_id
    end
  end
end
