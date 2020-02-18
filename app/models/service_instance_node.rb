require "archived_concern"

class ServiceInstanceNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_instance,      :optional => true
  belongs_to :root_service_instance, :optional => true, :class_name => "ServiceInstance"
  belongs_to :service_inventory,     :optional => true

  has_many :service_instance_node_service_credentials
  has_many :service_credentials, :through => :service_instance_node_service_credentials

  acts_as_tenant(:tenant)
end
