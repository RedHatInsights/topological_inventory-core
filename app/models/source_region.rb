require "archived_concern"

class SourceRegion < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :volumes

  acts_as_tenant(:tenant)
end
