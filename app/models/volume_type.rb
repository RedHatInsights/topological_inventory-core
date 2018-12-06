require "archived_concern"

class VolumeType < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :volumes

  acts_as_taggable
end
