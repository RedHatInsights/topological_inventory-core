class ApplicationRecord < ActiveRecord::Base
  require 'acts-as-taggable-on'

  self.abstract_class = true

  def as_json(options = {})
    options[:except] ||= []
    options[:except] << :tag_list
    super
  end
end
