require "archived_concern"

class ServiceCredentialType < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :service_credentials

  acts_as_tenant(:tenant)
end
