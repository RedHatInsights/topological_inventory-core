class ServicePlanClient
  def build_payload(external_catalog_name, external_service_plan_name, catalog_parameters)
    {
      "apiVersion" => "servicecatalog.k8s.io/v1beta1",
      "kind"       => "ServiceInstance",
      "metadata"   => {
        "name"      => "#{external_catalog_name}-#{SecureRandom.uuid}",
        "namespace" => "default"
       },
      "spec"       => {
         "clusterServiceClassExternalName" => external_catalog_name,
         "clusterServicePlanExternalName"  => external_service_plan_name,
         "parameters"                      => catalog_parameters
       }
    }
  end
end
