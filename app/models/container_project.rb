require "archived_concern"

class ContainerProject < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  has_many   :container_groups
  has_many   :container_templates

  acts_as_tenant(:tenant)
end
