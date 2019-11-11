require "archived_concern"

class ServiceInstanceNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_instance,      :optional => true
  belongs_to :root_service_instance, :optional => true, :class_name => "ServiceInstance"
  belongs_to :service_inventory,     :optional => true
  belongs_to :service_credential,    :optional => true

  acts_as_tenant(:tenant)
end
