class Tag < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  has_many :tagging
end
