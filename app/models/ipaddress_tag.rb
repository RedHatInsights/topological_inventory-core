class IpaddressTag < ApplicationRecord
  belongs_to :ipaddress
  belongs_to :tag
end
