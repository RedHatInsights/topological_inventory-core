class ServiceOfferingTag < ApplicationRecord
  belongs_to :service_offering
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
