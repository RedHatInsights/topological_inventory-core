require "archived_concern"

class Reservation < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :flavor, :optional => true

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
