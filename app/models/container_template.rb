class ContainerTemplate < ApplicationRecord
  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
end
