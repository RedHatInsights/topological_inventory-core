module TopologicalInventory
  module Persister
    module ArHelper
      def self.load_environment!
        require "active_record"

        app_root = Pathname.new(__dir__).join("../../../").expand_path
        $LOAD_PATH << app_root.join("app", "models")
        $LOAD_PATH << app_root.join("app", "models", "concerns")

        require "application_record"
        Dir[app_root.join("app/models/**/*.rb")].each { |f| require f }

        app_env = ENV["RAILS_ENV"] || "development"

        require "yaml"
        connection_spec = ENV["DATABASE_URL"] || YAML.load_file(app_root.join("config", "database.yml"))[app_env]
        ActiveRecord::Base.establish_connection(connection_spec)
      end
    end
  end
end
