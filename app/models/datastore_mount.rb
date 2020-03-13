class DatastoreMount < ApplicationRecord
  belongs_to :datastore
  belongs_to :host

  belongs_to :refresh_state_part, :optional => true
end
