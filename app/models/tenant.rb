class Tenant < ActiveRecord::Base
  has_many :authentications
  has_many :container_groups
  has_many :container_projects
  has_many :container_templates
  has_many :endpoints
  has_many :service_instances
  has_many :service_offerings
  has_many :service_plans
  has_many :sources
end

