require "archived_concern"

class ServiceOfferingNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering,      :optional => true
  belongs_to :root_service_offering, :optional => true, :class_name => "ServiceOffering"
  belongs_to :service_inventory,     :optional => true

  acts_as_tenant(:tenant)
end
