class HostNetworkAdapter < ApplicationRecord
  belongs_to :host
  belongs_to :network_adapter
end
