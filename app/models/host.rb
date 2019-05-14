require "archived_concern"

class Host < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :cluster, :optional => true

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
