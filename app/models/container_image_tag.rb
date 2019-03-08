class ContainerImageTag < ApplicationRecord
  belongs_to :container_image
  belongs_to :tag
end
