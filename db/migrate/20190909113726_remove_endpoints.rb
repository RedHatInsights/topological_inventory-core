class RemoveEndpoints < ActiveRecord::Migration[5.2]
  def up
    drop_table :endpoints
  end

  def down
    create_table "endpoints", force: :cascade do |t|
      t.string "role"
      t.integer "port"
      t.bigint "source_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "default", default: false
      t.string "scheme"
      t.string "host"
      t.string "path"
      t.bigint "tenant_id", null: false
      t.boolean "verify_ssl"
      t.text "certificate_authority"
      t.index ["source_id"], name: "index_endpoints_on_source_id"
      t.index ["tenant_id"], name: "index_endpoints_on_tenant_id"
    end
  end
end
