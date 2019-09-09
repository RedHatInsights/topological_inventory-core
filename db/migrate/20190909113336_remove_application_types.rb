class RemoveApplicationTypes < ActiveRecord::Migration[5.2]
  def up
    drop_table :application_types
  end

  def down
    create_table "application_types", force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "display_name"
      t.index ["name"], name: "index_application_types_on_name", unique: true
    end
  end
end
