class Source < ApplicationRecord
  has_many :endpoints, :dependent => :destroy, :autosave => true
  belongs_to :tenant

  delegate :scheme, :scheme=, :host, :host=, :port, :port=, :path, :path=,
           :to => :default_endpoint, :allow_nil => true

  def default_endpoint
    default = endpoints.detect(&:default)
    default || endpoints.build(:default => true, :tenant => tenant)
  end


  # Container Inventory Objects
  has_many :container_groups,    -> { active }, :dependent => :destroy
  has_many :container_templates, -> { active }, :dependent => :destroy
  has_many :container_projects,  -> { active }, :dependent => :destroy
  has_many :container_nodes,     -> { active }, :dependent => :destroy

  # Service Catalog Inventory Objects
  has_many :service_offerings,       -> { active }, :dependent => :destroy
  has_many :service_instances,       -> { active }, :dependent => :destroy
  has_many :service_parameters_sets, -> { active }, :dependent => :destroy
end
