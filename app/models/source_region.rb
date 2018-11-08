require "archived_concern"

class SourceRegion < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
end
