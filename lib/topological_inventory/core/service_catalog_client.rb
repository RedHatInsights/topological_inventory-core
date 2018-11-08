require "rest_client"
require "topological_inventory/core/service_plan_client"

module TopologicalInventory
  module Core
    class ServiceCatalogClient
      def initialize(source)
        @source = source
      end

      # TODO? Move this to a module in the API repo
      def order_service_plan(plan_name, service_offering_name, additional_parameters)
        payload = ServicePlanClient.new.build_payload(
          plan_name, service_offering_name, catalog_parameters(additional_parameters)
        )
        response = make_request(method: :post, url: order_service_plan_url, payload: payload)
        JSON.parse(response.body)
      end

      private

      def base_url
        URI.join(@source.default_endpoint.host, "apis/servicecatalog.k8s.io/v1beta1/").to_s
      end

      def order_service_plan_url
        URI.join(base_url, "namespaces/default/serviceinstances").to_s
      end

      def make_request(method:, url:, headers: generic_headers, payload: nil)
        request_options = {
          :method     => method,
          :url        => url,
          :headers    => headers,
          :verify_ssl => @source.default_endpoint.verify_ssl,
          :payload    => payload
        }

        request_options.merge!(:payload => payload) if payload.present?

        RestClient::Request.new(request_options).execute
      end

      def generic_headers
        {
          "Authorization" => "Bearer #{@source.default_endpoint.authentications.first.password}",
          "Content-Type"  => "application/json",
          "Accept"        => "application/json"
        }
      end

      def catalog_parameters(parameters)
        parameters.each_with_object({}) do |item, hash|
          hash[item['name']] = item['value']
        end
      end
    end
  end
end
