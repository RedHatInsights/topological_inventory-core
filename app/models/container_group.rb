require "archived_concern"

class ContainerGroup < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
  belongs_to :container_node

  has_many :containers

  acts_as_taggable
  acts_as_tenant(:tenant)
end
