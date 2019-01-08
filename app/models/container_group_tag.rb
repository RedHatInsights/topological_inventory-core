class ContainerGroupTag < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  belongs_to :container_group
  belongs_to :tag

  acts_as_tenant(:tenant)
end
