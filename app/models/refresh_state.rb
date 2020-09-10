require 'acts_as_tenant'

class RefreshState < ActiveRecord::Base
  belongs_to :source
  belongs_to :tenant
  has_many :refresh_state_parts

  acts_as_tenant(:tenant)
end
