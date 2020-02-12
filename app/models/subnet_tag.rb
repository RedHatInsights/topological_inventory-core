class SubnetTag < ApplicationRecord
  belongs_to :subnet
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
