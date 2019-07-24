require "archived_concern"

class Vm < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :orchestration_stack, :optional => true
  belongs_to :flavor, :optional => true

  has_many :volume_attachments
  has_many :volumes, :through => :volume_attachments

  has_many :network_adapters, :as => :resource

  acts_as_tenant(:tenant)
  acts_as_taggable_on
end
