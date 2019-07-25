class VmNetworkAdapter < ApplicationRecord
  belongs_to :vm
  belongs_to :network_adapter
end
