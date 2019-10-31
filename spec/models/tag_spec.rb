describe Tag do
  describe "#to_tag_string" do
    it "with a value" do
      expect(Tag.new(:namespace => "test_namespace", :name => "some_key", :value => "123abc").to_tag_string).to eq("/test_namespace/some_key=123abc")
    end

    it "with nil value" do
      expect(Tag.new(:namespace => "test_namespace", :name => "some_key", :value => nil).to_tag_string).to eq("/test_namespace/some_key")
    end

    it "with empty value" do
      expect(Tag.new(:namespace => "test_namespace", :name => "some_key", :value => "").to_tag_string).to eq("/test_namespace/some_key")
    end
  end
end
