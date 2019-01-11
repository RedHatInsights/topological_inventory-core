require 'more_core_extensions/core_ext/hash'

module TopologicalInventory
  module Core
    class ServicePlanClient
      def build_payload(service_plan_name, service_offering_name, order_parameters)
        # We need to not send empty strings in case the parameter is generated
        # More details are explained in the comment in the OpenShift web catalog
        # https://github.com/openshift/origin-web-catalog/blob/4c5cb3ee1ae0061ed28fc6190a0f8fff71771122/src/components/order-service/order-service.controller.ts#L442
        safe_params = order_parameters[:service_parameters].delete_blanks

        {
          "apiVersion" => "servicecatalog.k8s.io/v1beta1",
          "kind"       => "ServiceInstance",
          "metadata"   => {
            "name"      => "#{service_offering_name}-#{SecureRandom.uuid}",
            "namespace" => order_parameters[:provider_control_parameters][:namespace]
          },
          "spec"       => {
            "clusterServiceClassExternalName" => service_offering_name,
            "clusterServicePlanExternalName"  => service_plan_name,
            "parameters"                      => safe_params
          }
        }.to_json
      end
    end
  end
end
