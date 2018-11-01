require "archived_concern"

class ContainerGroup < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
  belongs_to :container_node

  acts_as_taggable
end
