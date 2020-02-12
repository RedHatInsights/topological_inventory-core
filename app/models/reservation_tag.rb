class ReservationTag < ApplicationRecord
  belongs_to :reservation
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
