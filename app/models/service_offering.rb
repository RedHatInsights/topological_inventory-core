require "archived_concern"

class ServiceOffering < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :service_offering_icon, :optional => true
  belongs_to :source
  belongs_to :source_region
  belongs_to :subscription
  belongs_to :service_inventory

  has_many   :service_instances
  has_many   :service_plans

  has_many :service_offering_nodes
  has_many :child_service_offering_nodes, :class_name => "ServiceOfferingNode", :foreign_key => :root_service_offering

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
