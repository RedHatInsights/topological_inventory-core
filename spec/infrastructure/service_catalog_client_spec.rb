describe ServiceCatalogClient do
  let(:subject) { described_class.new(source) }

  let(:endpoint) { Endpoint.new(:host => "https://example.com", :default => true) }
  let(:auth) { instance_double("Authentication", :password => "token") }
  let(:source) { Source.new(:endpoints => [endpoint]) }
  let(:dummy_rest_client) { double }
  let(:headers) do
    {
      "Authorization" => "Bearer token",
      "Content-Type"  => "application/json",
      "Accept"        => "application/json"
    }
  end
  let(:request_options) { {:method => method, :url => url, :headers => headers, :verify_ssl => true} }

  before do
    allow(RestClient::Request).to receive(:new).with(request_options).and_return(dummy_rest_client)
    allow(dummy_rest_client).to receive(:execute).and_return(double(:body => dummy_response.to_json))
    allow(endpoint).to receive(:authentications).and_return([auth])
  end

  describe "#get_catalog_name" do
    let(:url) { URI.join("https://example.com", "apis/servicecatalog.k8s.io/v1beta1/clusterserviceclasses").to_s }
    let(:method) { :get }
    let(:dummy_response) { {"items" => [{"metadata" => {"name" => 123}, "spec" => {"externalName" => "foo"}}]} }

    context "when the response does not contain a matching catalog id" do
      it "returns nil" do
        expect(subject.get_catalog_name(321)).to eq(nil)
      end
    end

    context "when the response contains a matching catalog id" do
      it "returns the external name of the catalog" do
        expect(subject.get_catalog_name(123)).to eq("foo")
      end
    end
  end

  describe "#get_plan_name" do
    let(:url) { URI.join("https://example.com", "apis/servicecatalog.k8s.io/v1beta1/clusterserviceplans").to_s }
    let(:method) { :get }
    let(:dummy_response) { {"items" => [{"metadata" => {"name" => 123}, "spec" => {"externalName" => "foo"}}]} }

    context "when the response does not contain a matching catalog id" do
      it "returns nil" do
        expect(subject.get_plan_name(321)).to eq(nil)
      end
    end

    context "when the response contains a matching catalog id" do
      it "returns the external name of the catalog" do
        expect(subject.get_plan_name(123)).to eq("foo")
      end
    end
  end

  describe "#order_service_plan" do
    let(:url) do
      URI.join("https://example.com", "apis/servicecatalog.k8s.io/v1beta1/namespaces/default/serviceinstances").to_s
    end
    let(:method) { :post }
    let(:post_request_options) do
      {
        :method     => method,
        :url        => url,
        :headers    => headers,
        :verify_ssl => true,
        :payload    => "payload"
      }
    end
    let(:dummy_response) { {"metadata" => {"selfLink" => "foo"}} }

    before do
      allow(RestClient::Request).to receive(:new).with(post_request_options).and_return(dummy_rest_client)
    end

    it "returns the expected response" do
      expect(subject.order_service_plan("payload").body).to eq(dummy_response.to_json)
    end
  end
end
