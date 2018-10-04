require "active_record"

app_root = File.expand_path("../", __dir__)
$LOAD_PATH << File.join(app_root, "app", "models")
$LOAD_PATH << File.join(app_root, "app", "models", "concerns")
Dir[File.expand_path("app/models/**/*.rb", app_root)].each { |f| require f }

app_env = ENV["TOPOLOGICAL_INVENTORY_ENV"] || "development"

require "yaml"
connection_spec = ENV["DATABASE_URL"] || YAML.load_file(File.expand_path("config/database.yml", app_root))[app_env]
ActiveRecord::Base.establish_connection(connection_spec)
