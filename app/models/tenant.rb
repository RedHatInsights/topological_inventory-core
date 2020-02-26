class Tenant < ApplicationRecord
  has_many :authentications
  has_many :containers
  has_many :container_groups
  has_many :container_images
  has_many :container_nodes
  has_many :container_projects
  has_many :container_resource_quotas
  has_many :container_templates
  has_many :datastores
  has_many :flavors
  has_many :ipaddresses
  has_many :network_adapters
  has_many :networks
  has_many :orchestration_stacks
  has_many :security_groups
  has_many :service_instances
  has_many :service_instance_nodes
  has_many :service_inventories
  has_many :service_offerings
  has_many :service_offering_nodes
  has_many :service_offering_icons
  has_many :service_plans
  has_many :source_regions
  has_many :subnets
  has_many :sources
  has_many :subscriptions
  has_many :tags
  has_many :tasks
  has_many :vms
  has_many :volumes
  has_many :volume_attachments
  has_many :volume_types

  has_many :refresh_states
  has_many :refresh_state_parts, :through => :refresh_states

  def self.tenancy_enabled?
    ENV["BYPASS_TENANCY"].blank?
  end
end
