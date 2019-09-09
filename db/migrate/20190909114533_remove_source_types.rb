class RemoveSourceTypes < ActiveRecord::Migration[5.2]
  def up
    drop_table :source_types
  end

  def down
    create_table "source_types", force: :cascade do |t|
      t.string "name", null: false
      t.string "product_name", null: false
      t.string "vendor", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.jsonb "schema"
      t.index ["name"], name: "index_source_types_on_name", unique: true
    end
  end
end
