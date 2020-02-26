class AddServiceCredentialTypeToServiceCredentials < ActiveRecord::Migration[5.2]
  def change
    add_reference :service_credentials, :service_credential_type, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
  end
end
