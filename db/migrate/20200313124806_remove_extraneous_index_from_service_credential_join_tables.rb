class RemoveExtraneousIndexFromServiceCredentialJoinTables < ActiveRecord::Migration[5.2]
  def up
    remove_index :service_instance_service_credentials, :name => 'index_service_instance_credentials_on_service_credential_id'
    remove_index :service_instance_node_service_credentials, :name => 'index_instance_node_credentials_on_service_credential_id'
    remove_index :service_offering_service_credentials, :name => 'index_service_offering_credentials_on_service_credential_id'
    remove_index :service_offering_node_service_credentials, :name => 'index_offering_node_credentials_on_service_credential_id'
  end

  def down
    add_index :service_offering_node_service_credentials, :service_credential_id, :name => 'index_offering_node_credentials_on_service_credential_id'
    add_index :service_offering_service_credentials, :service_credential_id, :name => 'index_service_offering_credentials_on_service_credential_id'
    add_index :service_instance_node_service_credentials, :service_credential_id, :name => 'index_instance_node_credentials_on_service_credential_id'
    add_index :service_instance_service_credentials, :service_credential_id, :name => 'index_service_instance_credentials_on_service_credential_id'
  end
end
