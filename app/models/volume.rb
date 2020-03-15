require "archived_concern"

class Volume < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :refresh_state_part, :optional => true
  belongs_to :source_region, :optional => true
  belongs_to :subscription, :optional => true
  belongs_to :orchestration_stack, :optional => true
  belongs_to :volume_type, :optional => true

  has_many :volume_attachments
  has_many :vms, :through => :volume_attachments

  acts_as_tenant(:tenant)
end
