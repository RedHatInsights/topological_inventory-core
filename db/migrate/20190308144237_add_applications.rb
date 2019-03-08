class AddApplications < ActiveRecord::Migration[5.2]
  def change
    create_table "applications" do |t|
      t.string "name", :null => false
      t.index %w(name), :unique => true
    end
  end
end
