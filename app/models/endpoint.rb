class Endpoint < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  has_many   :authentications, :as => :resource
end
