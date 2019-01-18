class ContainerNodeTag < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  belongs_to :container_node
  belongs_to :tag

  acts_as_tenant(:tenant)
end
