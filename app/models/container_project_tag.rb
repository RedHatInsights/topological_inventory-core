class ContainerProjectTag < ApplicationRecord
  belongs_to :container_project
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
