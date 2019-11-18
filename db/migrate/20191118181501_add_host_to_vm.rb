class AddHostToVm < ActiveRecord::Migration[5.2]
  def change
    add_reference :vms, :host, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
  end
end
