class AddMissingRelationToSubscriptionAndRegionToNetworkAdapter < ActiveRecord::Migration[5.2]
  def change
    add_reference :network_adapters, :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
    add_reference :network_adapters, :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
  end
end
