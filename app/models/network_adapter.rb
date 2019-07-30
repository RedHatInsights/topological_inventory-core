require "archived_concern"

class NetworkAdapter < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true

  belongs_to :device, :polymorphic => true

  acts_as_tenant(:tenant)
end
