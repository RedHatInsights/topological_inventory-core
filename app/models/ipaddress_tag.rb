class IpaddressTag < ApplicationRecord
  belongs_to :ipaddress
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
