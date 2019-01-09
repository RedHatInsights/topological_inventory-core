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
        payload = ServicePlanClient.new.build_payload(plan_name, service_offering_name, additional_parameters)
        response = make_request(:post, order_service_plan_url, payload)
        JSON.parse(response.body)
      end

      private

      def order_service_plan_url
        URI.join(@source.default_endpoint.base_url_path, "apis/servicecatalog.k8s.io/v1beta1/namespaces/default/serviceinstances").to_s
      end

      def make_request(method, url, payload, headers = generic_headers)
        request_options = {
          :method     => method,
          :url        => url,
          :headers    => headers,
          :verify_ssl => verify_ssl_mode,
          :payload    => payload
        }

        Rails.logger.info("Sending serviceinstance create with payload: #{payload}")
        RestClient::Request.new(request_options).execute
      end

      def generic_headers
        {
          "Authorization" => "Bearer #{@source.default_endpoint.authentications.first.password}",
          "Content-Type"  => "application/json",
          "Accept"        => "application/json"
        }
      end

      def verify_ssl_mode
        @source.default_endpoint.verify_ssl ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
      end
    end
  end
end
