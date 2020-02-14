class RemoveServiceCredentialReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :service_offerings, :service_credential, :index => true, :foreign_key => true
    remove_reference :service_instances, :service_credential, :index => true, :foreign_key => true
    remove_reference :service_offering_nodes, :service_credential, :index => true, :foreign_key => true
    remove_reference :service_instance_nodes, :service_credential, :index => true, :foreign_key => true
  end
end
