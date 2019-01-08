class Tag < ApplicationRecord
  belongs_to :tenant

  has_many :container_group_tags
  has_many :container_groups, :through => :container_group_tags

  has_many :container_image_tags
  has_many :container_images, :through => :container_image_tags

  has_many :vm_tags
  has_many :vms, :through => :vm_tags

  acts_as_tenant(:tenant)
end
