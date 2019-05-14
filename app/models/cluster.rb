require "archived_concern"

class Cluster < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :hosts

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
