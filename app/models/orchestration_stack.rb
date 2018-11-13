require "archived_concern"

class OrchestrationStack < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  acts_as_taggable
end
