module TopologicalInventory
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace TopologicalInventory

      initializer :append_migrations do |app|
        unless app.root.to_s == root.to_s
          config.paths["db/migrate"].expanded.each do |expanded_path|
            app.config.paths["db/migrate"] << expanded_path
          end
          ActiveRecord::Migrator.migrations_paths = app.config.paths["db/migrate"]
          ActiveRecord::Tasks::DatabaseTasks.migrations_paths = app.config.paths["db/migrate"].to_a
        end
      end
    end
  end
end
