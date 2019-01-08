class ApplicationRecord < ActiveRecord::Base
  # Hack for running acts_as_tenant in a non Rails env.
  # See https://github.com/ErwinM/acts_as_tenant/pull/192 for proposed fix
  begin
    module ::Rails
      module VERSION
        MAJOR = ActiveRecord::VERSION::MAJOR
      end
    end
  end if !defined?(::Rails) || !::Rails.const_defined?("VERSION")
  require 'acts_as_tenant'

  self.abstract_class = true

  def as_json(options = {})
    options[:except] ||= []
    options[:except] << :tag_list
    super
  end
end
