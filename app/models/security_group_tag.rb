class SecurityGroupTag < ApplicationRecord
  belongs_to :security_group
  belongs_to :tag
end
