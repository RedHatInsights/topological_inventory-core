require "archived_concern"

class VolumeType < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true

  has_many :volumes

  acts_as_tenant(:tenant)
end
