class VmTag < ApplicationRecord
  belongs_to :tenant

  belongs_to :vm
  belongs_to :tag

  acts_as_tenant(:tenant)
end
