class Endpoint < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  has_many   :authentications, :as => :resource

  validates :role, :uniqueness => { :scope => :source_id }

  acts_as_taggable
end
