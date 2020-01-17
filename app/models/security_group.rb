require "archived_concern"

class SecurityGroup < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true
  belongs_to :network, :optional => true

  has_many :vm_security_groups
  has_many :vms, :through => :vm_security_groups

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
