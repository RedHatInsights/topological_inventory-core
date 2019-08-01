require "archived_concern"

class Subscription < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :network_adapters
  has_many :networks
  has_many :orchestration_stacks
  has_many :security_groups
  has_many :service_instances
  has_many :service_offerings
  has_many :service_plans
  has_many :source_regions
  has_many :subnets
  has_many :vms
  has_many :volumes

  acts_as_tenant(:tenant)
end
