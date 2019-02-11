class ServiceOfferingTag < ApplicationRecord
  belongs_to :tenant

  belongs_to :service_offering
  belongs_to :tag

  acts_as_tenant(:tenant)
end
