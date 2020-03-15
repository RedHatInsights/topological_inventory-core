class ServiceOfferingIcon < ApplicationRecord
  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true

  has_many :service_offerings

  acts_as_tenant(:tenant)
end
