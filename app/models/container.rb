require "archived_concern"

class Container < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :container_group
  belongs_to :container_image
end
