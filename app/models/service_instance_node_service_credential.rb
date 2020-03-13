class ServiceInstanceNodeServiceCredential < ApplicationRecord
  belongs_to :service_credential
  belongs_to :service_instance_node
  belongs_to :tenant
  belongs_to :refresh_state_part, :optional => true

  acts_as_tenant(:tenant)
end
