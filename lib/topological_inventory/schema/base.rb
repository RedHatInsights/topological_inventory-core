require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Base < InventoryRefresh::Persister
      def to_hash
        {
          "schema": {
            "name": self.class.name.split("::").last # schema name
          },
          "source": manager.uid,
        }.merge(super)
      end

      def self.klass_for(name)
        klass_name = "TopologicalInventory::Schema::#{name}"
        klass = klass_name.safe_constantize

        # sometimes autoloader is confused and loads class with another namespace
        # checks whether it loads what we want
        klass if klass.to_s == klass_name
      end
    end
  end
end
