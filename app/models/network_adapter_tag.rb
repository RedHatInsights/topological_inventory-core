class NetworkAdapterTag < ApplicationRecord
  belongs_to :network_adapter
  belongs_to :tag
  belongs_to :tenant
  belongs_to :refresh_state_part, :optional => true
  acts_as_tenant(:tenant)
end
