require 'active_record_doctor'
require "active_record_doctor/tasks"
require 'active_record_doctor/tasks/missing_foreign_keys'

module TopologicalInventory
  module Core
    describe ApplicationRecord do
      it "checks that all foreign keys have foreign key constraint" do
        result, _success = ActiveRecordDoctor::Tasks::MissingForeignKeys.run

        expect(result).to be_empty
      end
    end
  end
end
