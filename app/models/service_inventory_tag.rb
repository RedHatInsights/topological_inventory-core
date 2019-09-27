class ServiceInventoryTag < ApplicationRecord
  belongs_to :service_inventory
  belongs_to :tag
end
