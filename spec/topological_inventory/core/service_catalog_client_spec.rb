module TopologicalInventory
  module Core
    describe ServiceCatalogClient do
      let(:subject) { described_class.new(source) }

      let(:endpoint) { Endpoint.new(:host => "https://example.com", :default => true, :verify_ssl => true) }
      let(:auth) { instance_double("Authentication", :password => "token") }
      let(:source) { Source.new(:endpoints => [endpoint]) }

      describe "#order_service_plan" do
        let(:url) do
          URI.join("https://example.com", "apis/servicecatalog.k8s.io/v1beta1/namespaces/default/serviceinstances").to_s
        end
        let(:post_request_options) do
          {
            :method     => :post,
            :url        => url,
            :headers    => headers,
            :verify_ssl => true,
            :payload    => "payload"
          }
        end
        let(:dummy_response) { {"metadata" => {"selfLink" => "foo"}} }
        let(:headers) do
          {
            "Authorization" => "Bearer token",
            "Content-Type"  => "application/json",
            "Accept"        => "application/json"
          }
        end
        let(:request_options) { {:method => method, :url => url, :headers => headers, :verify_ssl => true} }
        let(:catalog_parameters) { [{"name" => "foo", "value" => "bar"}, {"name" => "baz", "value" => "qux"}] }
        let(:service_plan_client) { instance_double("ServicePlanClient") }

        before do
          allow(ServicePlanClient).to receive(:new).and_return(service_plan_client)
          allow(service_plan_client).to receive(:build_payload).with(
            "plan_name", "service_offering_name", {"foo" => "bar", "baz" => "qux"}
          ).and_return("payload")

          stub_request(:post, url).with(:body => "payload", :headers => headers).
            to_return(:body => dummy_response.to_json)

          allow(endpoint).to receive(:authentications).and_return([auth])
        end

        it "builds the payload" do
          expect(service_plan_client).to receive(:build_payload).with(
            "plan_name", "service_offering_name", {"foo" => "bar", "baz" => "qux"}
          )

          subject.order_service_plan("plan_name", "service_offering_name", catalog_parameters)
        end

        it "returns the expected response" do
          expect(
            subject.order_service_plan("plan_name", "service_offering_name", catalog_parameters)
          ).to eq(dummy_response)
        end
      end
    end
  end
end
