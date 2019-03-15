require "manageiq/loggers"

module TopologicalInventory
  module Core
    class << self
      attr_writer :logger
    end

    def self.logger
      @logger ||= ManageIQ::Loggers::Container.new
    end

    module Logging
      def logger
        TopologicalInventory::Core.logger
      end
    end
  end
end
