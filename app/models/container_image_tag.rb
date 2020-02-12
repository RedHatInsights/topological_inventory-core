class ContainerImageTag < ApplicationRecord
  belongs_to :container_image
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
