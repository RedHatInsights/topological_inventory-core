require "archived_concern"

class ContainerProject < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true

  has_many   :container_groups
  has_many   :container_templates

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
