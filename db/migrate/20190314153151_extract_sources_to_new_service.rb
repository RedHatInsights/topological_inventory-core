class ExtractSourcesToNewService < ActiveRecord::Migration[5.2]
  def up
    remove_column :sources, :name
    remove_column :sources, :source_type_id
    remove_column :sources, :version

    drop_table :applications
    drop_table :application_types
    drop_table :authentications
    drop_table :availabilities
    drop_table :endpoints
    drop_table :source_types
  end

  def down
    create_table "application_types", :force => :cascade do |t|
      t.string "name", :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string "display_name"
      t.index ["name"], :name => "index_application_types_on_name", :unique => true
    end

    create_table "applications", :force => :cascade do |t|
      t.bigint "tenant_id", :null => false
      t.bigint "source_id", :null => false
      t.bigint "application_type_id", :null => false
      t.timestamps
      t.index ["application_type_id"], :name => "index_applications_on_application_type_id"
      t.index ["source_id"], :name => "index_applications_on_source_id"
      t.index ["tenant_id"], :name => "index_applications_on_tenant_id"
    end

    create_table "authentications", :force => :cascade do |t|
      t.string "resource_type"
      t.integer "resource_id"
      t.string "name"
      t.string "authtype"
      t.string "username"
      t.string "password"
      t.string "status"
      t.string "status_details"
      t.bigint "tenant_id", :null => false
      t.index ["resource_type", "resource_id"], :name => "index_authentications_on_resource_type_and_resource_id"
      t.index ["tenant_id"], :name => "index_authentications_on_tenant_id"
    end

    create_table "availabilities", :force => :cascade do |t|
      t.string "resource_type", :null => false
      t.bigint "resource_id", :null => false
      t.string "action", :null => false
      t.string "identifier", :null => false
      t.string "availability", :null => false
      t.datetime "last_checked_at"
      t.datetime "last_valid_at"
      t.timestamps
      t.index ["resource_type", "resource_id", "action", "identifier"], :name => "index_on_resource_action_identifier", :unique => true
    end

    create_table "endpoints", :force => :cascade do |t|
      t.string "role"
      t.integer "port"
      t.bigint "source_id"
      t.timestamps
      t.boolean "default", :default => false
      t.string "scheme"
      t.string "host"
      t.string "path"
      t.bigint "tenant_id", :null => false
      t.boolean "verify_ssl"
      t.text "certificate_authority"
      t.index ["source_id"], :name => "index_endpoints_on_source_id"
      t.index ["tenant_id"], :name => "index_endpoints_on_tenant_id"
    end

    create_table "source_types", :force => :cascade do |t|
      t.string "name", :null => false
      t.string "product_name", :null => false
      t.string "vendor", :null => false
      t.timestamps
      t.jsonb("schema")
      t.index ["name"], :name => "index_source_types_on_name", :unique => true
    end

    add_column    "sources", "name", "string", :null => false
    add_reference "sources", "source_type", :null => false, :index => true
    add_column    "sources", "version", "string"

    add_foreign_key("applications", "application_types", :on_delete => :cascade)
    add_foreign_key("applications", "sources", :on_delete => :cascade)
    add_foreign_key("applications", "tenants", :on_delete => :cascade)
    add_foreign_key("authentications", "tenants", :on_delete => :cascade)
    add_foreign_key("endpoints", "sources", :on_delete => :cascade)
    add_foreign_key("endpoints", "tenants", :on_delete => :cascade)
    add_foreign_key("sources", "source_types", :on_delete => :cascade)
  end
end
