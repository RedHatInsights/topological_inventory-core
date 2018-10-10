class ContainerTemplate < ApplicationRecord
  belongs_to :tenant
  belongs_to :source
end
