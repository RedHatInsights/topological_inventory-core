require "archived_concern"

class ServiceInstanceNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_instance
  belongs_to :root_service_instance, :class_name => "ServiceInstance"
  belongs_to :service_inventory

  acts_as_tenant(:tenant)
end
