class Task < ApplicationRecord
  belongs_to :tenant

  acts_as_taggable
end
