class SubnetTag < ApplicationRecord
  belongs_to :subnet
  belongs_to :tag
end
