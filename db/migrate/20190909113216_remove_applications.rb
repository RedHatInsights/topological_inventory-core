class RemoveApplications < ActiveRecord::Migration[5.2]
  def up
    drop_table :applications
  end

  def down
    create_table "applications", force: :cascade do |t|
      t.bigint "tenant_id", null: false
      t.bigint "source_id", null: false
      t.bigint "application_type_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["application_type_id"], name: "index_applications_on_application_type_id"
      t.index ["source_id"], name: "index_applications_on_source_id"
      t.index ["tenant_id"], name: "index_applications_on_tenant_id"
    end
  end
end
