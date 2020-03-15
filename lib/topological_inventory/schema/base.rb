require "inventory_refresh"
require "inventory_refresh/persister"

module TopologicalInventory
  module Schema
    class Base < InventoryRefresh::Persister
      def persist!
        link_data_to_refresh_state_part
        super
      end

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

      private

      def link_data_to_refresh_state_part
        refresh_state_part = ::RefreshStatePart.where(:uuid => refresh_state_part_uuid).first
        if refresh_state_part.present?
          ics = inventory_collections.select { |ic| ic.data.present? }
          ics.each do |ic|
            ic.data.each do |inventory_object|
              inventory_object.data[:refresh_state_part_id] = refresh_state_part.id
            end
          end
        end
      end
    end
  end
end
