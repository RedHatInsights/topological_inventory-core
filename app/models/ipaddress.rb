require "archived_concern"

class Ipaddress < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true

  belongs_to :network_adapter, :optional => true
  belongs_to :subnet, :optional => true

  has_many :ip_address_tags

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
