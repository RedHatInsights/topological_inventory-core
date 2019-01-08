class ContainerImageTag < ApplicationRecord
  belongs_to :tenant
  belongs_to :source

  belongs_to :container_image
  belongs_to :tag

  acts_as_tenant(:tenant)
end
