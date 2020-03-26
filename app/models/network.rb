require "archived_concern"

class Network < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true

  has_many :security_groups
  has_many :subnets

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
