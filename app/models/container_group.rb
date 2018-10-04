class ContainerGroup < ActiveRecord::Base
  belongs_to :source
  belongs_to :container_project
end
