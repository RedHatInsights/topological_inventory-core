class AddRegionsAndSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table "subscriptions", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.string     "source_ref"
      t.string     "name"
      t.timestamps
      t.datetime   "archived_on", :index => true
      t.index      %i(source_id source_ref), :unique => true
    end

    create_table "source_regions", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.string     "source_ref"
      t.string     "name"
      t.string     "endpoint"
      t.timestamps
      t.datetime   "archived_on", :index => true
      t.index      %i(source_id source_ref), :unique => true
    end

    add_reference :service_offerings, :source_region, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :service_offerings, :subscription, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
  
    add_reference :service_plans, :source_region, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :service_plans, :subscription, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}

    add_reference :service_instances, :source_region, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :service_instances, :subscription, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
  end
end
