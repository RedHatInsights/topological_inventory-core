require "archived_concern"

class Ipaddress < ApplicationRecord
  include ArchivedConcern

  belongs_to :network_adapter
  belongs_to :subnet, :optional => true
end
