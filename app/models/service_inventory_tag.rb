class ServiceInventoryTag < ApplicationRecord
  belongs_to :service_inventory
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
