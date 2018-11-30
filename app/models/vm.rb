require "archived_concern"
require "taggable"

class Vm < ApplicationRecord
  include ArchivedConcern
  include Taggable

  belongs_to :tenant
  belongs_to :source
  belongs_to :orchestration_stack, :optional => true
  belongs_to :flavor, :optional => true
end
