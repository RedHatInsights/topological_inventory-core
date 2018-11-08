describe ServicePlanClient do
  describe "#build_payload" do
    let(:expected_payload) do
      {
        "apiVersion" => "servicecatalog.k8s.io/v1beta1",
        "kind"       => "ServiceInstance",
        "metadata"   => {
          "name"      => "external_catalog_name-uuid",
          "namespace" => "default"
        },
        "spec"       => {
          "clusterServiceClassExternalName" => "external_catalog_name",
          "clusterServicePlanExternalName"  => "external_service_plan_name",
          "parameters"                      => "catalog_parameters"
        }
      }
    end

    before do
      allow(SecureRandom).to receive(:uuid).and_return("uuid")
    end

    it "returns the payload with the right data" do
      expect(
        subject.build_payload("external_catalog_name", "external_service_plan_name", "catalog_parameters")
      ).to eq(expected_payload)
    end
  end
end
