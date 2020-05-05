class AddForwardableHeadersRemoveRequestIdOnTask < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :forwardable_headers, :jsonb
    remove_column :tasks, :x_rh_insights_request
  end

  def down
    add_column :tasks, :x_rh_insights_request, :string
    remove_column :tasks, :forwardable_headers
  end
end
