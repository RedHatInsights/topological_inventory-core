require "archived_concern"

class Flavor < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :vms
  has_many :reservations

  acts_as_tenant(:tenant)
end
