class AddMissingForeignKeyConstraintToTasks < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :tasks, :tenants, on_delete: :cascade
  end
end
