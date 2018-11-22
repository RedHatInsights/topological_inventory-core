class RefreshState < ActiveRecord::Base
  belongs_to :source
  belongs_to :tenant
  has_many :refresh_state_parts

  def self.owner_ref(owner)
    {
      :source_id => owner.id,
      :tenant_id => owner.tenant_id,
    }
  end
end
