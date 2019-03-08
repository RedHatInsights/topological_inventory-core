class ServiceOfferingTag < ApplicationRecord
  belongs_to :service_offering
  belongs_to :tag
end
