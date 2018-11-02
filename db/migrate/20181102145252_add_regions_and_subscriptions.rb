class AddRegionsAndSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table "subscriptions", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => true, :null => false
      t.string     "source_ref"
      t.string     "name"
      t.timestamps
      t.datetime   "archived_on", :index => true
      t.index      %i(source_id source_ref), :unique => true
    end

    add_foreign_key :subscriptions, :sources, on_delete: :cascade

    create_table "source_regions", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => true, :null => false
      t.references "subscription", :type => :bigint, :index => true
      t.string     "source_ref"
      t.string     "name"
      t.string     "endpoint"
      t.timestamps
      t.datetime   "archived_on", :index => true
      t.index      %i(source_id source_ref), :unique => true
    end

    add_foreign_key :source_regions, :sources, on_delete: :cascade
    add_foreign_key :source_regions, :subscriptions, on_delete: :cascade

    # Relations to service_offerings
    add_column :service_offerings, :source_region_id, :bigint
    add_index :service_offerings, :source_region_id
    add_foreign_key :service_offerings, :source_regions, on_delete: :cascade

    add_column :service_offerings, :subscription_id, :bigint
    add_index :service_offerings, :subscription_id
    add_foreign_key :service_offerings, :subscriptions, on_delete: :cascade

    # Relations to service_plans
    add_column :service_plans, :source_region_id, :bigint
    add_index :service_plans, :source_region_id
    add_foreign_key :service_plans, :source_regions, on_delete: :cascade

    add_column :service_plans, :subscription_id, :bigint
    add_index :service_plans, :subscription_id
    add_foreign_key :service_plans, :subscriptions, on_delete: :cascade

    # Relations to service_instances
    add_column :service_instances, :source_region_id, :bigint
    add_index :service_instances, :source_region_id
    add_foreign_key :service_instances, :source_regions, on_delete: :cascade

    add_column :service_instances, :subscription_id, :bigint
    add_index :service_instances, :subscription_id
    add_foreign_key :service_instances, :subscriptions, on_delete: :cascade
  end
end
