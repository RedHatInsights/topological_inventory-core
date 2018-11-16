require "inventory_refresh"
require "manageiq-messaging"
require "topological_inventory/persister/logging"
require "topological_inventory/schema"

module TopologicalInventory
  module Persister
    class Worker
      include Logging

      def initialize(messaging_client_opts = {})
        self.messaging_client_opts = default_messaging_opts.merge(messaging_client_opts)

        InventoryRefresh.logger = logger
      end

      def run
        # Open a connection to the messaging service
        self.client = ManageIQ::Messaging::Client.open(messaging_client_opts)

        logger.info("Topological Inventory Persister started...")

        # Wait for messages to be processed
        client.subscribe_messages(queue_opts.merge(:max_bytes => 500000)) do |messages|
          messages.each do |msg|
            requeue = process_payload(msg.payload)

            if requeue
              logger.info("Message not processed, re-queuing...")
              client.publish_message(
                :service => "topological_inventory-persister",
                :message => "save_inventory",
                :payload => msg.payload,
              )
            end
          end
        end
      ensure
        client&.close
      end

      def stop
        client&.close
        self.client = nil
      end

      private

      attr_accessor :messaging_client_opts, :client

      def process_payload(payload)
        source = Source.find_by(:uid => payload["source"])
        raise "Couldn't find source with uid #{payload["source"]}" if source.nil?

        schema_name  = payload.dig("schema", "name")
        schema_klass = schema_klass_name(schema_name).safe_constantize
        raise "Invalid schema #{schema_name}" if schema_klass.nil?

        persister = schema_klass.from_hash(payload, source)
        persister.persist!
      rescue => e
        logger.error(e)
        logger.error(e.backtrace)
        nil
      end

      def schema_klass_name(name)
        "TopologicalInventory::Schema::#{name}"
      end

      def queue_opts
        {
          :service => "topological_inventory-persister",
        }
      end

      def default_messaging_opts
        {
          :protocol   => :Kafka,
          :client_ref => "persister-worker",
          :group_ref  => "persister-worker",
        }
      end
    end
  end
end
