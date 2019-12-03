describe Tag do
  REVERSIBLE_TEST_CASES = {
    {:name => "some_key",             :namespace => "test_namespace", :value => "123abc"} => "/test_namespace/some_key=123abc",
    {:name => "some_key",             :namespace => "test_namespace", :value => nil}      => "/test_namespace/some_key",
    {:name => "some_key",             :namespace => nil,              :value => "123abc"} => "//some_key=123abc",
    {:name => "some_key",             :namespace => nil,              :value => nil}      => "//some_key",
    {:name => "some_key/another_key", :namespace => "test_namespace", :value => "123abc"} => "/test_namespace/some_key/another_key=123abc",
    {:name => "some_key/another_key", :namespace => "test_namespace", :value => nil}      => "/test_namespace/some_key/another_key",
    {:name => "some_key/another_key", :namespace => nil,              :value => "123abc"} => "//some_key/another_key=123abc",
    {:name => "some_key/another_key", :namespace => nil,              :value => nil}      => "//some_key/another_key",
  }.freeze

  NON_REVERSIBLE_TEST_CASES = {
    {:name => "some_key", :namespace => "test_namespace", :value => ""} => "/test_namespace/some_key",
    {:name => "some_key", :namespace => nil,              :value => ""} => "//some_key",
  }.freeze

  it "#to_tag_string" do
    REVERSIBLE_TEST_CASES.merge(NON_REVERSIBLE_TEST_CASES).each do |properties, string|
      expect(Tag.new(properties).to_tag_string).to eq(string)
    end
  end

  it ".parse" do
    REVERSIBLE_TEST_CASES.each do |properties, string|
      expect(Tag.parse(string)).to eq(properties)
    end

    NON_REVERSIBLE_TEST_CASES.each do |properties, string|
      expect(Tag.parse(string)).to eq(properties.merge(:value => nil))
    end
  end
end
