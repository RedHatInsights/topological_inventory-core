require "archived_concern"

class ContainerImage < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :containers

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
