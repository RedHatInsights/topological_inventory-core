require "archived_concern"

class VmSecurityGroup < ApplicationRecord
  belongs_to :refresh_state_part, :optional => true

  belongs_to :vm
  belongs_to :security_group
end
