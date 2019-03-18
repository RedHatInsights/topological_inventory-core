require "manageiq/password/rspec_matchers"

describe Authentication do
  describe "#password" do
    let(:password) { "p4$$w0rd" }

    it "is encrypted" do
      auth = described_class.create!(:password => password, :tenant => Tenant.create!)

      expect(auth.password).to eq password
      expect(auth.password_encrypted).to be_encrypted(password)

      raw_sql   = described_class.select(:password).to_sql
      raw_value = ActiveRecord::Base.connection.select_value(raw_sql)
      expect(raw_value).to be_encrypted(password)
    end
  end
end
