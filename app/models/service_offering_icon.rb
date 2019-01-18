class ServiceOfferingIcon < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  has_many :service_offerings

  acts_as_tenant(:tenant)
end
