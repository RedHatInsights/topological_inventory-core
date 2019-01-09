require "archived_concern"

class ContainerTemplate < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
  has_many   :container_template_tags
  has_many   :tags, :through => :container_template_tags

  acts_as_tenant(:tenant)
end
