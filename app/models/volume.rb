require "archived_concern"

class Volume < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :source_region, :optional => true
  belongs_to :volume_type, :optional => true

  has_many :volume_attachments
  has_many :vms, :through => :volume_attachments
end
