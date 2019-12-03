class Tag < ApplicationRecord
  belongs_to :tenant

  has_many :container_group_tags
  has_many :container_groups, :through => :container_group_tags

  has_many :container_image_tags
  has_many :container_images, :through => :container_image_tags

  has_many :container_node_tags
  has_many :container_nodes, :through => :container_node_tags

  has_many :container_project_tags
  has_many :container_projects, :through => :container_project_tags

  has_many :container_template_tags
  has_many :container_templates, :through => :container_template_tags

  has_many :service_inventory_tags
  has_many :service_inventories, :through => :service_inventory_tags

  has_many :service_offering_tags
  has_many :service_offerings, :through => :service_offering_tags

  has_many :vm_tags
  has_many :vms, :through => :vm_tags

  has_many :reservation_tags
  has_many :reservations, :through => :reservation_tags

  # Network
  has_many :ipaddress_tags
  has_many :ipaddresses, :through => :ipaddress_tags
  has_many :network_adapter_tags
  has_many :network_adapters, :through => :network_adapter_tags
  has_many :network_tags
  has_many :networks, :through => :network_tags
  has_many :security_group_tags
  has_many :security_groups, :through => :security_group_tags
  has_many :subnet_tags
  has_many :subnets, :through => :subnet_tags

  acts_as_tenant(:tenant)

  def to_tag_string
    "/#{namespace}/#{name}".tap { |string| string << "=#{value}" if value.present? }
  end

  def self.create!(attributes)
    attributes = attributes.with_indifferent_access

    super(attributes.except(:tag).merge(parse(attributes[:tag])))
  end

  def self.parse(tag_string)
    return {} if tag_string.blank?

    raise ArgumentError, "must start with /" unless tag_string.start_with?("/")

    {}.tap do |tag_values|
      keyspace, tag_values[:value]                    = tag_string.split("=")
      _nil, tag_values[:namespace], tag_values[:name] = keyspace.split("/", 3)
    end
  end
end
