class RefreshStatePart < ActiveRecord::Base
  belongs_to :refresh_state
  belongs_to :tenant
end
