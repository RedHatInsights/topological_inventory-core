class Source < ApplicationRecord
  attribute :uid, :string, :default => -> { SecureRandom.uuid }

  has_many :availabilities, :as => :resource, :dependent => :destroy, :inverse_of => :resource

  belongs_to :tenant
  acts_as_tenant(:tenant)

  # Refresh tracker
  has_many :refresh_states
  has_many :refresh_state_parts, :through => :refresh_states

  # Container Inventory Objects
  has_many :container_groups
  has_many :container_group_tags, :through => :container_groups
  has_many :container_images
  has_many :container_image_tags, :through => :container_images
  has_many :container_resource_quotas
  has_many :container_templates
  has_many :container_template_tags, :through => :container_templates
  has_many :container_projects
  has_many :container_project_tags, :through => :container_projects
  has_many :container_nodes
  has_many :container_node_tags, :through => :container_nodes
  has_many :containers, :through => :container_groups

  # Service Catalog Inventory Objects
  has_many :service_offerings
  has_many :service_offering_nodes
  has_many :service_offering_icons
  has_many :service_offering_tags, :through => :service_offerings
  has_many :service_instances
  has_many :service_instance_nodes
  has_many :service_inventories
  has_many :service_inventory_tags, :through => :service_inventories
  has_many :service_plans
  has_many :source_regions
  has_many :subscriptions

  # Infra/Cloud
  has_many :hosts
  has_many :clusters
  has_many :cluster_tags, :through => :clusters
  has_many :datastores
  has_many :datastore_tags, :through => :datastores
  has_many :datastore_mounts, :through => :hosts
  has_many :flavors
  has_many :host_tags, :through => :hosts
  has_many :orchestration_stacks
  has_many :reservations
  has_many :reservation_tags, :through => :reservations
  has_many :vms
  has_many :vm_tags, :through => :vms

  # Network
  has_many :ipaddresses
  has_many :ipaddress_tags, :through => :ipaddresses
  has_many :network_adapters
  has_many :network_adapter_tags, :through => :network_adapters
  has_many :networks
  has_many :network_tags, :through => :networks
  has_many :security_groups
  has_many :security_group_tags, :through => :security_groups
  has_many :subnets
  has_many :subnet_tags, :through => :subnets
  has_many :vm_security_groups, :through => :vms

  # Storage
  has_many :volumes
  has_many :volume_attachments, :through => :volumes
  has_many :volume_types

  ALLOWED_REFRESH_STATUS_VALUES = ["deployed", "quota_limited"].freeze
  validates :refresh_status, :allow_nil => true, :inclusion => {:in => ALLOWED_REFRESH_STATUS_VALUES, :message => "%{value} is not included in #{ALLOWED_REFRESH_STATUS_VALUES}"}
end
