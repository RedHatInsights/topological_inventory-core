require "archived_concern"

class Vm < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true
  belongs_to :flavor, :optional => true

  has_many :volume_attachments
  has_many :volumes, :through => :volume_attachments

  has_many :network_adapters, :as => :device
  has_many :ipaddresses, :through => :network_adapters
  has_many :vm_security_groups
  has_many :security_groups, :through => :vm_security_groups

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
