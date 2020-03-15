class VolumeAttachment < ApplicationRecord
  belongs_to :tenant
  belongs_to :refresh_state_part, :optional => true
  belongs_to :volume
  belongs_to :vm

  acts_as_tenant(:tenant)
end
