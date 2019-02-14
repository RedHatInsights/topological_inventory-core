class Tag < ApplicationRecord
  belongs_to :tenant

  has_many :taggings

  acts_as_tenant(:tenant)
end
