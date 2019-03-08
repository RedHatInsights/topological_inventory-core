class AddSourceApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :source_applications do |t|
      t.references :source, :index => false
      t.references :application, :index => false
      t.index %i(source_id application_id), :unique => true
    end
  end
end
