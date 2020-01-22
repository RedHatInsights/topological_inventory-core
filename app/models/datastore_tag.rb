class DatastoreTag < ApplicationRecord
  belongs_to :datastore
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
