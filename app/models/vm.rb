require "archived_concern"

class Vm < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :orchestration_stack, :optional => true
  belongs_to :flavor, :optional => true

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  #acts_as_taggable
end
