require "archived_concern"

class ServiceOfferingNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering,      :optional => true
  belongs_to :root_service_offering, :optional => true, :class_name => "ServiceOffering"
  belongs_to :service_inventory,     :optional => true

  has_many :service_offering_node_service_credentials
  has_many :service_credentials, :through => :service_offering_node_service_credentials

  acts_as_tenant(:tenant)
end
