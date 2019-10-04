class AddRootServiceInstanceToServiceInstances < ActiveRecord::Migration[5.2]
  def change
    add_reference :service_instances, :root_service_instance, :index => true, :null => true,
                  :foreign_key => {:on_delete => :nullify, :to_table => 'service_instances'}
  end
end
