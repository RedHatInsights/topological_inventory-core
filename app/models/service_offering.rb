require "archived_concern"

class ServiceOffering < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :service_offering_icon, :optional => true
  belongs_to :source_region
  belongs_to :subscription
  belongs_to :service_inventory, :optional => true

  has_many   :service_instances
  has_many   :service_plans

  has_many :service_offering_nodes
  has_many :child_service_offering_nodes, :class_name => "ServiceOfferingNode", :foreign_key => :root_service_offering

  has_many :service_offering_service_credentials
  has_many :service_credentials, :through => :service_offering_service_credentials

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
