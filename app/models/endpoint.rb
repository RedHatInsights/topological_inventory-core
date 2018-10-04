class Endpoint < ActiveRecord::Base
  belongs_to :source
  has_many :authentications, :as => :resource
end
