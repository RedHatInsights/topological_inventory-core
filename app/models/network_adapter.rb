require "archived_concern"

class NetworkAdapter < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :resource, :polymorphic => true

  acts_as_tenant(:tenant)
end
