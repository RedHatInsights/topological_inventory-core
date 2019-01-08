require "archived_concern"
require "topological_inventory/core/service_catalog_client"

class ServicePlan < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :source_region
  belongs_to :subscription

  has_many   :service_instances

  acts_as_tenant(:tenant)

  def order(additional_parameters)
    parsed_response = service_catalog_client.order_service_plan(name, service_offering.name, additional_parameters)

    {
      :service_instance => {
        :source_id  => source.id,
        :source_ref => parsed_response['metadata']['selfLink']
      }
    }
  end

  private

  def service_catalog_client
    @service_catalog_client ||= TopologicalInventory::Core::ServiceCatalogClient.new(source)
  end
end
