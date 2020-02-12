class ContainerGroupTag < ApplicationRecord
  belongs_to :container_group
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
