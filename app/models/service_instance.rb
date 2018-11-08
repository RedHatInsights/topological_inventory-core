require "archived_concern"

class ServiceInstance < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :service_plan
  belongs_to :source_region
  belongs_to :subscription

  acts_as_taggable
end
