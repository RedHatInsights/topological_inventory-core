require "topological_inventory/core/service_plan_client"

module TopologicalInventory
  module Core
    describe ServicePlanClient do
      describe "#build_payload" do
        let(:order_parameters) do
          {
            :service_parameters => service_parameters,
            :provider_control_parameters => {:namespace => "namespace"}
          }
        end
        let(:service_parameters) { {"DB_NAME" => "TEST_DB", "namespace" => "TEST_DB_NAMESPACE"} }
        let(:expected_payload) do
          {
            "apiVersion" => "servicecatalog.k8s.io/v1beta1",
            "kind"       => "ServiceInstance",
            "metadata"   => {
              "name"      => "service_offering_name-uuid",
              "namespace" => "namespace"
            },
            "spec"       => {
              "clusterServiceClassExternalName" => "service_offering_name",
              "clusterServicePlanExternalName"  => "service_plan_name",
              "parameters"                      => service_parameters
            }
          }.to_json
        end

        before do
          allow(SecureRandom).to receive(:uuid).and_return("uuid")
        end

        it "returns the payload with the right data" do
          expect(
            subject.build_payload("service_plan_name", "service_offering_name", order_parameters)
          ).to eq(expected_payload)
        end
      end
    end
  end
end
