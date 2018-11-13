module TopologicalInventory
  module Core
    class SeedLoader
      def self.load_seed
        load File.join(__dir__, "../../../db/seeds.rb")
      end
    end
  end
end
