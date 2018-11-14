class ApplicationRecord < ActiveRecord::Base
  require 'acts-as-taggable-on'

  self.abstract_class = true

  def as_json(options = nil)
  end
end
