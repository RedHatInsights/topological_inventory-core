class ServiceInstanceServiceCredential < ApplicationRecord
  belongs_to :service_credential
  belongs_to :service_instance
  belongs_to :tenant

  acts_as_tenant(:tenant)
end
