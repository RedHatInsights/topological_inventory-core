require "archived_concern"

class ServiceOfferingNode < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :root_service_offering, :class_name => "ServiceOffering"
  belongs_to :service_inventory

  acts_as_tenant(:tenant)
end
