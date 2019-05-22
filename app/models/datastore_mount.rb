class DatastoreMount < ApplicationRecord
  belongs_to :datastore
  belongs_to :host
end
