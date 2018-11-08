require "archived_concern"

class Subscription < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
end
