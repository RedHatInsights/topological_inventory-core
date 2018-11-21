require "topological_inventory/core/service_plan_client"

module TopologicalInventory
  module Core
    describe ServicePlanClient do
      describe "#build_payload" do
        let(:expected_payload) do
          {
            "apiVersion" => "servicecatalog.k8s.io/v1beta1",
            "kind"       => "ServiceInstance",
            "metadata"   => {
              "name"      => "service_offering_name-uuid",
              "namespace" => "default"
            },
            "spec"       => {
              "clusterServiceClassExternalName" => "service_offering_name",
              "clusterServicePlanExternalName"  => "service_plan_name",
              "parameters"                      => "catalog_parameters"
            }
          }.to_json
        end

        before do
          allow(SecureRandom).to receive(:uuid).and_return("uuid")
        end

        it "returns the payload with the right data" do
          expect(
            subject.build_payload("service_plan_name", "service_offering_name", "catalog_parameters")
          ).to eq(expected_payload)
        end
      end
    end
  end
end
