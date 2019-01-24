require 'active_record_doctor'
require "active_record_doctor/tasks"
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_foreign_keys'
require 'active_record_doctor/tasks/extraneous_indexes'

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

      it "checks there are no extraneous indexes (for columns already covered by multi-column indexes)" do
        result, _success = ActiveRecordDoctor::Tasks::ExtraneousIndexes.run

        expect(result).to be_empty
      end

      it "checks all archived_at columns have index in all tables" do
        expect(missing_column_indexes("archived_at")).to be_empty
      end

      it "checks all last_seen_at columns have index in all tables" do
        expect(missing_column_indexes("last_seen_at")).to be_empty
      end

      it "checks all tables have tenant_id with NOT NULL constraint" do
        # We have few system level tables that shouldn't have tenant id
        exceptions = ["tenants", "source_types", "schema_migrations", "ar_internal_metadata"]

        expect(not_having_column_with_not_null_constraint("tenant_id", exceptions)).to be_empty
      end

      it "check all tables having source_ref have NOT NULL constraint on it" do
        expect(missing_not_null_constraint("source_ref")).to be_empty
      end

      def not_having_column_with_not_null_constraint(column_name, exceptions = [])
        (connection.tables - exceptions).select do |table|
          !connection.columns(table).detect {|column| column.name == column_name && !column.null}
        end
      end

      def missing_not_null_constraint(column_name)
        (connection.tables).select do |table|
          connection.columns(table).detect {|column| column.name == column_name && column.null}
        end
      end

      def missing_column_indexes(column_name)
        connection.tables.select do |table|
          connection.columns(table).map(&:name).include?(column_name)
        end.reject do |table|
          connection.indexes(table).detect do |index|
            index.columns.include?(column_name)
          end
        end
      end

      def connection
        ApplicationRecord.connection
      end
    end
  end
end
