describe ServicePlan do
  describe "#order" do
    let(:service_plan) { described_class.new(:id => 456) }

    let(:external_api_broker) { instance_double("ExternalApiBroker") }
    let(:catalog_id) { 123 }
    let(:catalog_name) { "external_catalog_name" }
    let(:plan_name) { "external_plan_name" }
    let(:parameters) { [{"name" => "foo", "value" => "bar"}, {"name" => "baz", "value" => "qux"}] }

    let(:expected_payload) do
      {
        "apiVersion" => "servicecatalog.k8s.io/v1beta1",
        "kind"       => "ServiceInstance",
        "metadata"   => {
          "name"      => "external_catalog_name-randomuuid",
          "namespace" => "default"
        },
        "spec"       => {
          "clusterServiceClassExternalName" => "external_catalog_name",
          "clusterServicePlanExternalName"  => "external_plan_name",
          "parameters"                      => {
            "foo" => "bar",
            "baz" => "qux"
          }
        }
      }
    end

    let(:api_response) { double(:body => {"metadata" => {"selfLink" => 321}}.to_json) }

    before do
      allow(SecureRandom).to receive(:uuid).and_return("randomuuid")
      allow(ExternalApiBroker).to receive(:new).and_return(external_api_broker)
      allow(external_api_broker).to receive(:get_plan_name).with(456).and_return(plan_name)
      allow(external_api_broker).to receive(:order_service_plan).with(expected_payload).and_return(api_response)
    end

    context "when the catalog has an external name" do
      before do
        allow(external_api_broker).to receive(:get_catalog_name).with(123).and_return(catalog_name)
      end

      it "uses the external api broker to order a service plan" do
        expect(external_api_broker).to receive(:order_service_plan).with(expected_payload)
        service_plan.order(catalog_id, parameters)
      end

      it "returns the task id" do
        expect(service_plan.order(catalog_id, parameters)).to eq(321)
      end
    end

    context "when the catalog does not have an external name" do
      before do
        allow(external_api_broker).to receive(:get_catalog_name).with(123).and_return(nil)
      end

      it "raises an error" do
        expect { service_plan.order(catalog_id, parameters) }.to raise_error("external name not found for catalog 123")
      end
    end
  end
end
