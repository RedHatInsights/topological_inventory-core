require "archived_concern"

class Datastore < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
