class Tagging < ApplicationRecord
  belongs_to :resource, :polymorphic => true
  belongs_to :tag

  acts_as_tenant(:tenant)
end
