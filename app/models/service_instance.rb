require "archived_concern"

class ServiceInstance < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :service_plan
end
