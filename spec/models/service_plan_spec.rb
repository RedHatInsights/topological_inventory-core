describe ServicePlan do
  describe "#order" do
    let(:service_plan) { described_class.new(:id => 456, :source => source, :tenant => tenant) }
    let(:source) { Source.new(:id => 654) }
    let(:tenant) { Tenant.new }

    let(:service_catalog_client) { instance_double("ServiceCatalogClient") }
    let(:catalog_id) { 123 }
    let(:parameters) { "parameters" }

    let(:parsed_api_response) { {"metadata" => {"selfLink" => 321}} }

    before do
      allow(ServiceCatalogClient).to receive(:new).with(source).and_return(service_catalog_client)
      allow(service_catalog_client).to receive(:order_service_plan).with(456, catalog_id, parameters).and_return(
        parsed_api_response
      )
    end

    it "orders the service plan" do
      expect(service_catalog_client).to receive(:order_service_plan).with(456, catalog_id, parameters)
      service_plan.order(catalog_id, parameters)
    end

    it "creates a task with context information" do
      service_plan.order(catalog_id, parameters)
      expect(Task.last.context).to eq(
        {:service_instance => {:source_id => 654, :source_ref => 321}}.with_indifferent_access
      )
    end

    it "returns the task id" do
      expect(service_plan.order(catalog_id, parameters)).to eq(Task.last.id)
    end
  end
end
