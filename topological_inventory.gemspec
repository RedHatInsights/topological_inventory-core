$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "topological_inventory/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "topological_inventory"
  s.version     = TopologicalInventory::VERSION
  s.authors     = ["Adam Grare"]
  s.email       = ["agrare@redhat.com"]
  s.homepage    = ""
  s.summary     = "Summary of TopologicalInventory."
  s.description = "Description of TopologicalInventory."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.7"
  s.add_dependency "pg", "~> 0.18.2"
  s.add_dependency "manageiq-messaging", "~> 0.1.0"
end
