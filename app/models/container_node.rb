require "archived_concern"

class ContainerNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :lives_on, :polymorphic => true, :optional => true
  has_many   :container_groups
  has_many   :container_node_tags
  has_many   :tags, :through => :container_node_tags

  acts_as_tenant(:tenant)
end
