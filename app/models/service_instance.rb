class ServiceInstance < ActiveRecord::Base
  belongs_to :source
  belongs_to :service_offering
  belongs_to :service_parameters_set
end
