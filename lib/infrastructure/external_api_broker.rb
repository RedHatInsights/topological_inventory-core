require "rest_client"

class ExternalApiBroker
  def get_catalog_name(catalog_id)
    get_object_name(catalog_id, catalog_url)
  end

  def get_plan_name(plan_id)
    get_object_name(plan_id, plan_url)
  end

  def order_service_plan(payload)
    make_request(method: :post, url: order_service_plan_url, payload: payload)
  end

  private

  def base_url
    "https://localhost"
  end

  def catalog_url
    URI.join(base_url, "apis/servicecatalog.k8s.io/v1beta1/clusterserviceclasses").to_s
  end

  def order_service_plan_url
    URI.join(base_url, "apis/servicecatalog.k8s.io/v1beta1/namespaces/default/serviceinstances").to_s
  end

  def plan_url
    URI.join(base_url, "apis/servicecatalog.k8s.io/v1beta1/clusterserviceplans").to_s
  end

  def make_request(method:, url:, headers: generic_headers, payload: nil)
    request_options = {
      :method     => method,
      :url        => url,
      :headers    => headers,
      :verify_ssl => true
    }

    request_options.merge(:payload => payload) if payload.present?

    RestClient::Request.new(request_options).execute
  end

  def generic_headers
    token = "???"
    {
      "Authorization" => "Bearer #{token}", # Token?
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
end
