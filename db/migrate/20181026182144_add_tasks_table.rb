class AddTasksTable < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks, :id => :bigserial do |t|
      t.string :name
      t.string :status
      t.string :state
      t.references :tenant, :index => true, :null => false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
