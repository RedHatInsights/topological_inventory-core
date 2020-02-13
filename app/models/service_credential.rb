require "archived_concern"

class ServiceCredential < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  belongs_to :service_credential_type, :optional => true

  acts_as_tenant(:tenant)
end
