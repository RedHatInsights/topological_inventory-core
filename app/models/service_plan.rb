require "archived_concern"
require_relative "../../lib/infrastructure/external_api_broker"

class ServicePlan < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :service_offering
  belongs_to :source_region
  belongs_to :subscription

  has_many   :service_instances

  acts_as_taggable

  def order(catalog_id, additional_parameters)
    payload = external_payload(catalog_id, additional_parameters)

    response = external_api_broker.order_service_plan(payload)

    parsed_data = JSON.parse(response.body)
    parsed_data['metadata']['selfLink']
  end

  private

  def external_payload(catalog_id, parameters)
    external_catalog_name = external_api_broker.get_catalog_name(catalog_id)
    raise "external name not found for catalog #{catalog_id}" unless external_catalog_name

    {
      "apiVersion" => "servicecatalog.k8s.io/v1beta1",
      "kind"       => "ServiceInstance",
      "metadata"   => {
        "name"      => "#{external_catalog_name}-#{SecureRandom.uuid}",
        "namespace" => "default"
       },
      "spec"       => {
         "clusterServiceClassExternalName" => external_catalog_name,
         "clusterServicePlanExternalName"  => external_api_broker.get_plan_name(id),
         "parameters"                      => catalog_parameters(parameters)
       }
    }
  end

  def catalog_parameters(parameters)
    parameters.each_with_object({}) do |item, hash|
      hash[item['name']] = item['value']
    end
  end

  def external_api_broker
    @external_api_broker ||= ::ExternalApiBroker.new
  end
end
