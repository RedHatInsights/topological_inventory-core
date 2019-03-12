class AddApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :source, :index => false
      t.references :application_type, :index => false
      t.index %i(source_id application_type_id), :unique => true
    end
  end
end
