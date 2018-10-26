require "archived_concern"

class ContainerNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  has_many   :container_groups

  acts_as_taggable
end
