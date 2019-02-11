class ContainerProjectTag < ApplicationRecord
  belongs_to :tenant

  belongs_to :container_project
  belongs_to :tag

  acts_as_tenant(:tenant)
end
