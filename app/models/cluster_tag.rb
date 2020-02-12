class ClusterTag < ApplicationRecord
  belongs_to :cluster
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
