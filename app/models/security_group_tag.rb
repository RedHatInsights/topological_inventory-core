class SecurityGroupTag < ApplicationRecord
  belongs_to :security_group
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
