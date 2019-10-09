class AddInventoryRelationToServiceOfferingsAndInstances < ActiveRecord::Migration[5.2]
  def change
    add_reference :service_offerings, :service_inventory, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
    add_reference :service_instances, :service_inventory, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
  end
end
