class ServiceOfferingNodeServiceCredential < ApplicationRecord
  belongs_to :service_credential
  belongs_to :service_offering_node
  belongs_to :tenant

  acts_as_tenant(:tenant)
end
