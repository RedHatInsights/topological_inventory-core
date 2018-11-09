describe "ActsAsTaggableOn" do
  let(:tenant) { Tenant.find_or_create_by!(:name => "default") }
  let(:source) { Source.find_or_create_by!(:name => "OCP", :uid => "9a874712-9a55-49ab-a46a-c823acc35503", :tenant => tenant, :source_type => source_type) }
  let(:source_type) { SourceType.find_or_create_by!(:name => "openshift", :product_name => "OpenShift", :vendor => "Red Hat") }

  context "common tagging operations" do
    it "is taggable" do
      expect(source.is_taggable?).to be_truthy
    end

    it "tags an object with a single tag" do
      source.tag_list.add("awesome")
      source.save!

      expect(source.tag_list).to eq(["awesome"])
    end

    it "untags an object with a single tag" do
      source.tag_list.add("totally", "awesome")
      source.save!

      expect(source.tags.length).to eq(2)

      source.tag_list.remove("awesome")
      source.save!

      expect(source.tag_list).to eq(["totally"])
    end

    it "can add and remove tags by direct assignment" do
      source.tag_list = ["totally", "freaking", "awesome"]
      source.save!

      expect(source.tag_list).to eq(["totally", "freaking", "awesome"])

      source.tag_list = []
      source.save!

      expect(source.tag_list).to eq([])
    end

    it "finds objects by tag" do
      source.tag_list = ["totally", "freaking", "awesome"]
      source.save!

      expect(Source.tagged_with("freaking").take.id).to                         eq(source.id)
      expect(Source.tagged_with(["totally", "awesome"]).take.id).to             eq(source.id)
      expect(Source.tagged_with(["totally", "freaking", "awesome"]).take.id).to eq(source.id)
    end
  end
end
