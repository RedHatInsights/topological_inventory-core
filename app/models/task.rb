class Task < ApplicationRecord
  belongs_to :tenant

  acts_as_tenant(:tenant)
end
