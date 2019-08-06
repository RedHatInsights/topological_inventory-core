class AddMissingRelationToSubscriptionRegionAndStack < ActiveRecord::Migration[5.2]
  def change
    add_reference :orchestration_stacks, :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
    add_reference :orchestration_stacks, :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
    add_reference :orchestration_stacks, :parent_orchestration_stack, :index => true, :null => true,
                  :foreign_key => {:to_table => :orchestration_stacks, :on_delete => :cascade}

    add_reference :vms, :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
    add_reference :vms, :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

    add_reference :volumes, :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
    add_reference :volumes, :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
  end
end
