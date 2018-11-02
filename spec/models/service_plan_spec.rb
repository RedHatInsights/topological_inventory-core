describe ServicePlan do
  describe "#order" do
    let(:service_plan) { described_class.new(:id => 456, :source => source, :tenant => tenant) }
    let(:source) { Source.new }
    let(:tenant) { Tenant.new }

    let(:service_catalog_client) { instance_double("ServiceCatalogClient") }
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
      allow(ServiceCatalogClient).to receive(:new).with(source).and_return(service_catalog_client)
      allow(service_catalog_client).to receive(:get_plan_name).with(456).and_return(plan_name)
      allow(service_catalog_client).to receive(:order_service_plan).with(expected_payload).and_return(api_response)
    end

    context "when the catalog has an external name" do
      before do
        allow(service_catalog_client).to receive(:get_catalog_name).with(123).and_return(catalog_name)
      end

      it "uses the external api broker to order a service plan" do
        expect(service_catalog_client).to receive(:order_service_plan).with(expected_payload)
        service_plan.order(catalog_id, parameters)
      end

      it "creates a task by passing the metadata to the task context" do
        expect(Task).to receive(:create!).with(:tenant => tenant, :context => 321).and_call_original
        service_plan.order(catalog_id, parameters)
      end

      it "returns the task id" do
        expect(service_plan.order(catalog_id, parameters)).to eq(Task.where(:context => 321).first.id)
      end
    end

    context "when the catalog does not have an external name" do
      before do
        allow(service_catalog_client).to receive(:get_catalog_name).with(123).and_return(nil)
      end

      it "raises an error" do
        expect { service_plan.order(catalog_id, parameters) }.to raise_error("external name not found for catalog 123")
      end
    end
  end
end
