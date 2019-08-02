require "archived_concern"

class VmSecurityGroup < ApplicationRecord
  belongs_to :vm
  belongs_to :security_group
end
