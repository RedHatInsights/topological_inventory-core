module TopologicalInventory
  module Core
    class ServicePlanClient
      def build_payload(service_plan_name, service_offering_name, catalog_parameters)
        {
          "apiVersion" => "servicecatalog.k8s.io/v1beta1",
          "kind"       => "ServiceInstance",
          "metadata"   => {
            "name"      => "#{service_offering_name}-#{SecureRandom.uuid}",
            "namespace" => "default"
          },
          "spec"       => {
            "clusterServiceClassExternalName" => service_offering_name,
            "clusterServicePlanExternalName"  => service_plan_name,
            "parameters"                      => catalog_parameters
          }
        }
      end
    end
  end
end
