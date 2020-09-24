class RefreshState < ActiveRecord::Base
  require 'acts_as_tenant'

  belongs_to :source
  belongs_to :tenant
  has_many :refresh_state_parts

  acts_as_tenant(:tenant)
end
