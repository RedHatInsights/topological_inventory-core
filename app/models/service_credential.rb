require "archived_concern"

class ServiceCredential < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :service_offerings
  has_many :service_offering_nodes
  has_many :service_instances
  has_many :service_instance_nodes

  acts_as_tenant(:tenant)
end
