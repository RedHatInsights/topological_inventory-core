require "archived_concern"

class Flavor < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :vms

  acts_as_taggable
end
