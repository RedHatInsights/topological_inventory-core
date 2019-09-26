require "archived_concern"

class ServiceInventory < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  acts_as_tenant(:tenant)
end
