class AddMissingNameToContainerTemplate < ActiveRecord::Migration[5.1]
  def change
    add_column :container_templates, :name, :string
  end
end
