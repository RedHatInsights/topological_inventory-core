class Source < ApplicationRecord
  has_many :endpoints, :autosave => true
  belongs_to :source_type
  belongs_to :tenant

  delegate :scheme, :scheme=, :host, :host=, :port, :port=, :path, :path=,
           :to => :default_endpoint, :allow_nil => true

  acts_as_tenant(:tenant)

  def default_endpoint
    default = endpoints.detect(&:default)
    default || endpoints.build(:default => true, :tenant => tenant)
  end

  # Refresh tracker
  has_many :refresh_states
  has_many :refresh_state_parts, :through => :refresh_states

  # Container Inventory Objects
  has_many :container_groups
  has_many :container_group_tags, :through => :container_groups
  has_many :container_images
  has_many :container_image_tags, :through => :container_images
  has_many :container_templates
  has_many :container_template_tags, :through => :container_templates
  has_many :container_projects
  has_many :container_project_tags, :through => :container_projects
  has_many :container_nodes
  has_many :container_node_tags, :through => :container_nodes
  has_many :containers, :through => :container_groups

  # Service Catalog Inventory Objects
  has_many :service_offerings
  has_many :service_offering_tags, :through => :service_offerings
  has_many :service_instances
  has_many :service_plans
  has_many :source_regions
  has_many :subscriptions

  # Infra/Cloud
  has_many :flavors
  has_many :orchestration_stacks
  has_many :vms
  has_many :vm_tags, :through => :vms

  # Storage
  has_many :volumes
  has_many :volume_attachments, :through => :volumes
  has_many :volume_types
end
