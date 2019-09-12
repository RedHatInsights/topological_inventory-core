require "archived_concern"

class OrchestrationStack < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :parent_orchestration_stack, :class_name => "OrchestrationStack", :optional => true

  has_many :child_orchestration_stacks, :class_name => "OrchestrationStack", :foreign_key => :parent_orchestration_stack_id
  has_many :ipaddresses
  has_many :network_adapters
  has_many :networks
  has_many :security_groups
  has_many :subnets
  has_many :vms
  has_many :reservations
  has_many :volumes

  acts_as_tenant(:tenant)
end
