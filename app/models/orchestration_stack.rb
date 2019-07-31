require "archived_concern"

class OrchestrationStack < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :floating_ips
  has_many :network_adapters
  has_many :networks
  has_many :security_groups
  has_many :subnets
  has_many :vms

  acts_as_tenant(:tenant)
end
