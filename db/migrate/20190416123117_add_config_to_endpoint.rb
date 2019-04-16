class AddConfigToEndpoint < ActiveRecord::Migration[5.2]
  def change
    add_column :endpoints, :config, :string
  end
end
