class VmTag < ApplicationRecord
  belongs_to :vm
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
