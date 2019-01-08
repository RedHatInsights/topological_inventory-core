require "archived_concern"

class ContainerGroup < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
  belongs_to :container_node

  has_many :containers
  has_many :container_group_tags
  has_many :tags, :through => :container_group_tags

  acts_as_tenant(:tenant)
end
