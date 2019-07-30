require "archived_concern"

class SecurityGroup < ApplicationRecord
  belongs_to :vm
  belongs_to :security_group
end
