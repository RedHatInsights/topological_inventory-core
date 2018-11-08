require "rest_client"

class ServiceCatalogClient
  def initialize(source)
    @source = source
  end

  def get_catalog_name(catalog_id)
    get_object_name(catalog_id, catalog_url)
  end

  def get_plan_name(plan_id)
    get_object_name(plan_id, plan_url)
  end

  # TODO? Move this to a module in the API repo
  def order_service_plan(plan_id, catalog_id, additional_parameters)
    payload = build_service_plan_payload(plan_id, catalog_id, additional_parameters)
    response = make_request(method: :post, url: order_service_plan_url, payload: payload)
    JSON.parse(response.body)
  end

  private

  def base_url
    URI.join(@source.default_endpoint.host, "apis/servicecatalog.k8s.io/v1beta1/").to_s
  end

  def catalog_url
    URI.join(base_url, "clusterserviceclasses").to_s
  end

  def order_service_plan_url
    URI.join(base_url, "namespaces/default/serviceinstances").to_s
  end

  def plan_url
    URI.join(base_url, "clusterserviceplans").to_s
  end

  def make_request(method:, url:, headers: generic_headers, payload: nil)
    request_options = {
      :method     => method,
      :url        => url,
      :headers    => headers,
      :verify_ssl => @source.default_endpoint.verify_ssl
    }

    request_options.merge(:payload => payload) if payload.present?

    RestClient::Request.new(request_options).execute
  end

  def generic_headers
    {
      "Authorization" => "Bearer #{@source.default_endpoint.authentications.first.password}",
      "Content-Type"  => "application/json",
      "Accept"        => "application/json"
    }
  end

  def get_object_name(object_id, url)
    response = make_request(method: :get, url: url)

    parsed_data = JSON.parse(response.body)
    entry = parsed_data['items'].each.detect { |item| object_id == item['metadata']['name'] }
    entry ? entry['spec']['externalName'] : nil
  end

  def build_service_plan_payload(plan_id, catalog_id, additional_parameters)
    external_catalog_name = get_catalog_name(catalog_id)
    raise "external name not found for catalog #{catalog_id}" unless external_catalog_name
    external_service_plan_name = get_plan_name(plan_id)
    catalog_parameters(additional_parameters)

    ServicePlanClient.new.build_payload(
      external_catalog_name, external_service_plan_name, catalog_parameters(additional_parameters)
    )
  end

  def catalog_parameters(parameters)
    parameters.each_with_object({}) do |item, hash|
      hash[item['name']] = item['value']
    end
  end
end
