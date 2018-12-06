class Tenant < ActiveRecord::Base
  has_many :authentications
  has_many :containers
  has_many :container_groups
  has_many :container_images
  has_many :container_projects
  has_many :container_templates
  has_many :flavors
  has_many :endpoints
  has_many :orchestration_stacks
  has_many :service_instances
  has_many :service_offerings
  has_many :service_plans
  has_many :source_regions
  has_many :sources
  has_many :subscriptions
  has_many :tasks
  has_many :vms
  has_many :volumes
  has_many :volume_attachments
  has_many :volume_types

  has_many :refresh_states
  has_many :refresh_state_parts, :through => :refresh_states

  acts_as_taggable
end

