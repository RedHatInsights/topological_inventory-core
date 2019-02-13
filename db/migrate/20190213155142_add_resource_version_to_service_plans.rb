class AddResourceVersionToServicePlans < ActiveRecord::Migration[5.2]
  def change
    add_column :service_plans, :resource_version, :string
  end
end
