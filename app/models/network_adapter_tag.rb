class NetworkAdapterTag < ApplicationRecord
  belongs_to :network_adapter
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
