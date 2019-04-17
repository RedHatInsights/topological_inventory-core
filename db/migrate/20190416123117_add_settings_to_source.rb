class AddSettingsToSource < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :settings, :jsonb
  end
end
