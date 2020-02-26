require "archived_concern"

class ServiceInstance < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :service_plan
  belongs_to :source_region
  belongs_to :subscription
  belongs_to :service_inventory,     :optional => true
  belongs_to :root_service_instance, :optional => true, :class_name => "ServiceInstance"

  has_many :service_instance_nodes
  has_many :child_service_instance_nodes, :class_name => "ServiceInstanceNode", :foreign_key => :root_service_instance

  has_many :service_instance_service_credentials
  has_many :service_credentials, :through => :service_instance_service_credentials

  acts_as_tenant(:tenant)
end
