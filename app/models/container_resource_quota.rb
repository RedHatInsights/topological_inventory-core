require "archived_concern"

class ContainerResourceQuota < ApplicationRecord
  self.table_name = "container_resource_quotas"

  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :container_project

  acts_as_tenant(:tenant)
end
