class ContainerGroup < ApplicationRecord
  belongs_to :tenant
  belongs_to :source
  belongs_to :container_project
  belongs_to :container_node
end
