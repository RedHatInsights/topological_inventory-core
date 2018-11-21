describe ServicePlan do
  describe "#order" do
    let(:service_plan) do
      described_class.create!(:source           => source,
                              :tenant           => tenant,
                              :name             => "plan_name",
                              :service_offering => service_offering)
    end
    let(:source) { Source.create!(:tenant => tenant) }
    let(:service_offering) do
      ServiceOffering.create!(:source => source, :tenant => tenant, :name => "service_offering")
    end
    let(:tenant) { Tenant.create! }

    let(:service_catalog_client) { instance_double("ServiceCatalogClient") }
    let(:parameters) { "parameters" }

    let(:parsed_api_response) { {"metadata" => {"selfLink" => 321}} }

    before do
      allow(TopologicalInventory::Core::ServiceCatalogClient).to receive(:new).with(source).and_return(
        service_catalog_client
      )
      allow(service_catalog_client).to receive(:order_service_plan).with(
        "plan_name", "service_offering", parameters
      ).and_return(parsed_api_response)
    end

    it "orders the service plan" do
      expect(service_catalog_client).to receive(:order_service_plan).with("plan_name", "service_offering", parameters)
      service_plan.order(parameters)
    end

    it "creates a task with context information" do
      service_plan.order(parameters)
      expect(Task.last.context).to eq({"service_instance" => {"source_id" => source.id, "source_ref" => 321}})
    end

    it "returns the task id" do
      expect(service_plan.order(parameters)).to eq(Task.last.id)
    end
  end
end
