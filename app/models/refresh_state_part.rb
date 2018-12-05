class RefreshStatePart < ActiveRecord::Base
  belongs_to :refresh_state
  belongs_to :tenant

  acts_as_tenant(:tenant)
end
