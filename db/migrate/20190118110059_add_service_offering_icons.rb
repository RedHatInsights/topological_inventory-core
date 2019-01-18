class AddServiceOfferingIcons < ActiveRecord::Migration[5.2]
  def change
    create_table "service_offering_icons", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "source_ref", :null => false
      t.binary "data"
      t.timestamps

      t.index      %i(source_id source_ref), :unique => true
    end

    add_reference :service_offerings, :service_offering_icon, :type => :bigint, :index => true, :foreign_key => {:on_delete => :nullify}
  end
end
