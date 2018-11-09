require "topological_inventory/persister/worker"

describe TopologicalInventory::Persister::Worker do
  let(:tenant) { Tenant.find_or_create_by!(:name => "default") }
  let(:source_type) { SourceType.find_or_create_by(:name => "openshift") }
  let(:client) { double(:client) }
  let(:test_inventory_dir) { Pathname.new(__dir__).join("test_inventory") }
  let!(:source) do
    Source.find_or_create_by!(
      :tenant      => tenant,
      :source_type => source_type,
      :name        => "OCP",
      :uid         => "9a874712-9a55-49ab-a46a-c823acc35503",
    )
  end

  context "#run" do
    let(:messages) { [ManageIQ::Messaging::ReceivedMessage.new(nil, nil, inventory, nil)] }

    before do
      allow(ManageIQ::Messaging::Client).to receive(:open).and_return(client)
      allow(client).to receive(:close)
      allow(client).to receive(:subscribe_messages).and_yield(messages)

      described_class.new.run
      source.reload
    end

    context "with a simple payload" do
      let(:inventory) { JSON.load(File.read(test_inventory_dir.join("simple_inventory.json"))) }

      it "saves the container group" do
        expect(source.container_projects.count).to eq(1)
        expect(source.container_projects.first).to have_attributes(
          :source_ref       => "c56c6854-baaf-11e8-ba7e-d094660d31fb",
          :name             => "default",
          :display_name     => "Default",
          :resource_version => "42001363",
        )
      end

      it "sets the tenant to the source's tenant" do
        expect(source.container_projects.first.tenant).to eq(source.tenant)
      end
    end

    context "with some inter-object relationships" do
      let(:inventory) { JSON.load(File.read(test_inventory_dir.join("relationships_inventory.json"))) }

      it "saves the different inventory objects" do
        expect(source.container_projects.count).to eq(1)
        expect(source.container_nodes.count).to    eq(1)
        expect(source.container_groups.count).to   eq(1)
        expect(source.containers.count).to         eq(2)
      end

      it "saves the relationships between objects" do
        container_group = source.container_groups.first
        container_project = source.container_projects.first
        container_node = source.container_nodes.first

        expect(container_group.container_project).to eq(container_project)
        expect(container_group.container_node).to eq(container_node)
        expect(container_group.containers.count).to eq(2)
      end
    end
  end
end
