class RenameServiceParametersSetsToServicePlans < ActiveRecord::Migration[5.1]
  def change
    rename_table :service_parameters_sets, :service_plans
    rename_column :service_instances, :service_parameters_set_id, :service_plan_id
  end
end
