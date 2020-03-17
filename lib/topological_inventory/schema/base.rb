require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Base < InventoryRefresh::Persister
      attr_accessor :refresh_time_tracking

      def initialize(manager)
        self.refresh_time_tracking = {:persister_started_at => Time.now.utc.to_datetime.to_s}
        super(manager)
      end

      # TODO: add time_tracking?
      def to_hash
        {
          "schema": {
            "name": self.class.name.split("::").last # schema name
          },
          "source": manager.uid,
        }.merge(super)
      end

      class << self
        def from_hash(persister_data, manager)
          persister = super(persister_data, manager)
          %i[
            refresh_state_part_collected_at
            refresh_state_part_sent_at
            refresh_state_started_at
            refresh_state_sent_at
            ingress_api_sent_at
          ].each do |timestamp_name|
            persister.refresh_time_tracking[timestamp_name] = persister_data[timestamp_name.to_s]
          end
          persister
        end

        def klass_for(name)
          klass_name = "TopologicalInventory::Schema::#{name}"
          klass = klass_name.safe_constantize

          # sometimes autoloader is confused and loads class with another namespace
          # checks whether it loads what we want
          klass if klass.to_s == klass_name
        end
      end
    end
  end
end
