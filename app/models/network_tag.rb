class NetworkTag < ApplicationRecord
  belongs_to :network
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
