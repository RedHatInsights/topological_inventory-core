class DatastoreTag < ApplicationRecord
  belongs_to :datastore
  belongs_to :tag
end
