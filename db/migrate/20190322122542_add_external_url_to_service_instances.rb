class AddExternalUrlToServiceInstances < ActiveRecord::Migration[5.2]
  def change
    add_column :service_instances, :external_url, :string
  end
end
