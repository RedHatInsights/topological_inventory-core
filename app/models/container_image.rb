require "archived_concern"

class ContainerImage < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source

  has_many :containers
  has_many :container_image_tags
  has_many :tags, :through => :container_image_tags

  acts_as_tenant(:tenant)

  def taggings
    container_image_tags.map do |tagging|
      {
        :tag_id => tagging.tag_id,
        :name   => tagging.tag.name,
        :value  => tagging.value,
      }
    end
  end
end
