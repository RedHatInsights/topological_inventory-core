module TopologicalInventory
  module Core
    class ServicePlanClient
      def build_payload(service_plan_name, service_offering_name, order_parameters)
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
            "parameters"                      => order_parameters[:service_parameters]
          }
        }.to_json
      end
    end
  end
end
