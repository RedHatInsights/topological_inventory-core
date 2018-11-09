module TopologicalInventory
  module Persister
    class << self
      attr_writer :logger
    end

    def self.logger
      @logger ||= Logger.new(STDOUT, :level => Logger::INFO)
    end

    module Logging
      def logger
        TopologicalInventory::Persister.logger
      end
    end
  end
end
