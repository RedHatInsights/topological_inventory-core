require 'active_record_doctor'
require "active_record_doctor/tasks"
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_foreign_keys'

module TopologicalInventory
  module Core
    describe ApplicationRecord do
      it "checks that all foreign keys have foreign key constraint" do
        result, _success = ActiveRecordDoctor::Tasks::MissingForeignKeys.run

        expect(result).to be_empty
      end

      it "checks all foreign keys are covered by indexes" do
        result, _success = ActiveRecordDoctor::Tasks::UnindexedForeignKeys.run

        expect(result).to be_empty
      end
    end
  end
end
