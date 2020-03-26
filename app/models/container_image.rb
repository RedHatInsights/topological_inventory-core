require "archived_concern"

class ContainerImage < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true

  has_many :containers

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
