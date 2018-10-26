require "archived_concern"

class ServiceOffering < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many   :service_instances
  has_many   :service_plans

  acts_as_taggable
end
