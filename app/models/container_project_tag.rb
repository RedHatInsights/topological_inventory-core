class ContainerProjectTag < ApplicationRecord
  belongs_to :container_project
  belongs_to :tag
end
