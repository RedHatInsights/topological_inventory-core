class AddJsonSpecToParametersSets < ActiveRecord::Migration[5.1]
  def change
    add_column :service_parameters_sets, :create_json_schema, :jsonb
    add_column :service_parameters_sets, :update_json_schema, :jsonb
  end
end
