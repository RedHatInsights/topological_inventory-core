require "archived_concern"

class ServicePlan < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering

  has_many   :service_instances
end
