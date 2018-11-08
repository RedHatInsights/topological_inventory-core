class AddTenantIdToRegionsAndSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :source_regions, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}, :null => false
    add_reference :subscriptions, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}, :null => false
  end
end
