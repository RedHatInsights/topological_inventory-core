require "archived_concern"
require "taggable"

class ServiceOffering < ApplicationRecord
  include ArchivedConcern
  include Taggable

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region
  belongs_to :subscription

  has_many   :service_instances
  has_many   :service_plans
end
