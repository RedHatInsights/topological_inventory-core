require "archived_concern"

class OrchestrationStack < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  acts_as_taggable
  acts_as_tenant(:tenant)
end
