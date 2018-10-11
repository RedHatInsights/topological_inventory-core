class ContainerNode < ApplicationRecord
  belongs_to :tenant
  belongs_to :source
  has_many   :container_groups, :dependent => :nullify
end
