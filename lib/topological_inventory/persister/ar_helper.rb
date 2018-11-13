module TopologicalInventory
  module Persister
    module ArHelper
      def self.load_environment!
        ENV["RAILS_ENV"] ||= "development"

        require "yaml"
        database_yaml_path = root.join("config", "database.yml")
        database_yaml = YAML.load_file(database_yaml_path) if database_yaml_path.exist?

        require "active_record"
        ActiveRecord::Tasks::DatabaseTasks.env = ENV["RAILS_ENV"]
        ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_yaml || {}
        ActiveRecord::Tasks::DatabaseTasks.db_dir = root.join("db")
        ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [root.join("db/migrate")]

        load_models

        require "topological_inventory/core/seed_loader"
        ActiveRecord::Tasks::DatabaseTasks.seed_loader = TopologicalInventory::Core::SeedLoader
        ActiveRecord::Tasks::DatabaseTasks.root = root
        ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration

        ActiveRecord::Base.establish_connection(ENV["RAILS_ENV"].to_sym)
      end

      private_class_method def self.load_models
        $LOAD_PATH << root.join("app", "models")
        $LOAD_PATH << root.join("app", "models", "concerns")

        require "application_record"
        Dir[root.join("app/models/**/*.rb")].each { |f| require f }
      end

      private_class_method def self.root
        @root ||= Pathname.new(__dir__).join("../../..").expand_path
      end
    end
  end
end
