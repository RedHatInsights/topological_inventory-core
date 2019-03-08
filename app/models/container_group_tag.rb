class ContainerGroupTag < ApplicationRecord
  belongs_to :container_group
  belongs_to :tag
end
