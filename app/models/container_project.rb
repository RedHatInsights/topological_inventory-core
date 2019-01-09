require "archived_concern"

class ContainerProject < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  has_many   :container_groups
  has_many   :container_templates
  has_many   :container_project_tags
  has_many   :tags, :through => :container_project_tags

  acts_as_tenant(:tenant)
end
