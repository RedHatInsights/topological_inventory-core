class Tagging < ApplicationRecord
  belongs_to :taggable, :polymorphic => true
  belongs_to :tagger,   :polymorphic => true

  belongs_to :tag
end
