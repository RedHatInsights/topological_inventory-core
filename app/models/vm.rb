require "archived_concern"

class Vm < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :orchestration_stack

  acts_as_taggable
end
