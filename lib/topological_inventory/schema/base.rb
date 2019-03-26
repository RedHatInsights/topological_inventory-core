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
    end
  end
end
