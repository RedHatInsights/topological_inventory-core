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
        result, _success = EnhancedUnindexedForeignKeys.run

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

      it "checks all tables exposed to ingress API have last_seen_at column" do
        exceptions = ["authentications", "refresh_states", "refresh_state_parts", "endpoints", "sources", "tasks",
                      "applications"]
        exceptions += internal_tables

        expect(not_having_column_with_type("last_seen_at", :datetime, exceptions)).to be_empty
      end

      it "checks all tables have tenant_id with NOT NULL constraint" do
        # We have few system level tables that shouldn't have tenant id
        exceptions = ["container_node_tags", "service_offering_tags", "container_group_tags", "container_project_tags",
                      "container_image_tags", "container_template_tags", "vm_tags"]
        exceptions += internal_tables

        expect(not_having_column_with_not_null_constraint("tenant_id", exceptions)).to be_empty
      end

      it "check all tables having source_ref have NOT NULL constraint on it" do
        expect(missing_not_null_constraint("source_ref")).to be_empty
      end

      def not_having_column_with_not_null_constraint(column_name, exceptions = [])
        (connection.tables - exceptions).reject do |table|
          connection.columns(table).detect { |column| column.name == column_name && !column.null }
        end
      end

      def missing_not_null_constraint(column_name)
        connection.tables.select do |table|
          connection.columns(table).detect { |column| column.name == column_name && column.null }
        end
      end

      def not_having_column_with_type(column_name, column_type, exceptions = [])
        (connection.tables - exceptions).reject do |table|
          connection.columns(table).detect { |column| column.name == column_name && column.type == column_type}
        end
      end

      def missing_column_indexes(column_name, exceptions = [])
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

      def internal_tables
        ["tenants", "source_types", "schema_migrations", "ar_internal_metadata", "availabilities",
         "application_types"]
      end
    end
  end

  class EnhancedUnindexedForeignKeys < ActiveRecordDoctor::Tasks::UnindexedForeignKeys
    def indexed_as_polymorphic?(table, column)
      type_column_name = column.name.sub(/_id\Z/, '_type')
      connection.indexes(table).any? do |index|
        index.columns.include?(type_column_name) && index.columns.include?(column.name)
      end
    end
  end
end
