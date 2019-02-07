class Tenant < ActiveRecord::Base
  has_many :authentications
  has_many :containers
  has_many :container_groups
  has_many :container_group_tags
  has_many :container_images
  has_many :container_image_tags
  has_many :container_nodes
  has_many :container_node_tags
  has_many :container_projects
  has_many :container_project_tags
  has_many :container_templates
  has_many :container_template_tags
  has_many :flavors
  has_many :endpoints
  has_many :orchestration_stacks
  has_many :service_instances
  has_many :service_offerings
  has_many :service_offering_icons
  has_many :service_offering_tags
  has_many :service_plans
  has_many :source_regions
  has_many :sources
  has_many :subscriptions
  has_many :tags
  has_many :tasks
  has_many :vms
  has_many :vm_tags
  has_many :volumes
  has_many :volume_attachments
  has_many :volume_types

  has_many :refresh_states
  has_many :refresh_state_parts, :through => :refresh_states

  def self.tenancy_enabled?
    ENV["BYPASS_TENANCY"].blank?
  end
end

