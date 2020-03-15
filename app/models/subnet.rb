require "archived_concern"

class Subnet < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true

  belongs_to :network, :optional => true

  has_many :ipaddresses
  has_many :network_adapters, :through => :ipaddresses
  has_many :vms, :through => :network_adapters, :source => :device, :source_type => "Vm"

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
