class ApplicationRecord < ActiveRecord::Base
  require 'acts-as-taggable-on'
  require 'acts_as_tenant'

  self.abstract_class = true

  def as_json(options = {})
    options[:except] ||= []
    options[:except] << :tag_list
    super
  end
end
