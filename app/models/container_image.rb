require "archived_concern"

class ContainerImage < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :containers
  has_many :container_image_tags
  has_many :tags, :through => :container_image_tags

  acts_as_tenant(:tenant)
end
