class ContainerNodeTag < ApplicationRecord
  belongs_to :container_node
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
