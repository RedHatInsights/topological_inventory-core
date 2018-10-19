require "topological_inventory/persister/worker"

describe TopologicalInventory::Persister::Worker do
  let(:tenant) { Tenant.create! }
  let(:client) { double(:client) }
  let!(:source) { Source.create!(:name => "OCP", :uid => "9a874712-9a55-49ab-a46a-c823acc35503", :tenant => tenant) }

  context "#run" do
    before do
      allow(ManageIQ::Messaging::Client).to receive(:open).and_return(client)
      allow(client).to receive(:close)
      allow(client).to receive(:subscribe_topic).and_yield(nil, nil, inventory)
    end

    context "with a simple payload" do
      let(:inventory) { JSON.load(File.read(File.expand_path(File.join("test_inventory", "simple_inventory.json"), __dir__))) }

      it "saves the container group" do
        described_class.new.run
        expect(source.reload.container_projects.count).to eq(1)
      end
    end
  end
end
