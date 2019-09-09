class RemoveAuthentications < ActiveRecord::Migration[5.2]
  def up
    drop_table :authentications
  end

  def down
    create_table "authentications", force: :cascade do |t|
      t.string "resource_type"
      t.integer "resource_id"
      t.string "name"
      t.string "authtype"
      t.string "username"
      t.string "password"
      t.string "status"
      t.string "status_details"
      t.bigint "tenant_id", null: false
      t.index ["resource_type", "resource_id"], name: "index_authentications_on_resource_type_and_resource_id"
      t.index ["tenant_id"], name: "index_authentications_on_tenant_id"
    end
  end
end
