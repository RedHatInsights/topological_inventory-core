require "archived_concern"

class ServicePlan < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :service_offering
  belongs_to :source_region
  belongs_to :subscription

  has_many   :service_instances

  acts_as_tenant(:tenant)
end
