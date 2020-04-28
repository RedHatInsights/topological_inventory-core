class AddRequestIdToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :x_rh_insights_request, :string
  end
end
