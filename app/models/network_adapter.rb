require "archived_concern"

class NetworkAdapter < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true

  belongs_to :device, :polymorphic => true, :optional => true

  has_many :ipaddresses

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
