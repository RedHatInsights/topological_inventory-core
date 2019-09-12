class ReservationTag < ApplicationRecord
  belongs_to :reservation
  belongs_to :tag
end
