require "archived_concern"

class Host < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :cluster, :optional => true

  has_many :datastore_mounts
  has_many :datastores, :through => :datastore_mounts

  has_many :host_network_adapters
  has_many :network_adapters, :through => :host_network_adapters

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
