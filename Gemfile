source 'https://rubygems.org'

# Declare your gem's dependencies in topological_inventory.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "inventory_refresh", :git => "https://github.com/ManageIQ/inventory_refresh", :branch => "master"
gem "manageiq-messaging", :git => "https://github.com/ManageIQ/manageiq-messaging", :branch => "master"
gem "manageiq-gems-pending", :git => "https://github.com/ManageIQ/manageiq-gems-pending", :branch => "master"

group :development, :test do
  gem "rspec-rails"
  gem "byebug"
end
