require "archived_concern"

class Datastore < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :datastore_mounts
  has_many :hosts, :through => :datastore_mounts

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
