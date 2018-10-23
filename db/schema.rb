# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181018141423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string "resource_type"
    t.integer "resource_id"
    t.string "name"
    t.string "authtype"
    t.string "userid"
    t.string "password"
    t.string "status"
    t.string "status_details"
    t.bigint "tenant_id"
    t.index ["resource_type", "resource_id"], name: "index_authentications_on_resource_type_and_resource_id"
  end

  create_table "container_groups", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.bigint "container_project_id"
    t.string "ipaddress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.bigint "container_node_id"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_container_groups_on_archived_on"
    t.index ["container_node_id"], name: "index_container_groups_on_container_node_id"
    t.index ["container_project_id"], name: "index_container_groups_on_container_project_id"
    t.index ["source_deleted_at"], name: "index_container_groups_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_groups_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_groups_on_source_id"
  end

  create_table "container_nodes", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.integer "cpus"
    t.bigint "memory"
    t.bigint "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_container_nodes_on_archived_on"
    t.index ["source_deleted_at"], name: "index_container_nodes_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_nodes_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_nodes_on_source_id"
    t.index ["tenant_id"], name: "index_container_nodes_on_tenant_id"
  end

  create_table "container_projects", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_container_projects_on_archived_on"
    t.index ["source_deleted_at"], name: "index_container_projects_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_projects_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_projects_on_source_id"
  end

  create_table "container_templates", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "resource_version"
    t.bigint "container_project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.datetime "source_created_at"
    t.string "name"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_container_templates_on_archived_on"
    t.index ["container_project_id"], name: "index_container_templates_on_container_project_id"
    t.index ["source_deleted_at"], name: "index_container_templates_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_templates_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_templates_on_source_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.string "role"
    t.integer "port"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default"
    t.string "scheme"
    t.string "host"
    t.string "path"
    t.bigint "tenant_id"
    t.index ["source_id"], name: "index_endpoints_on_source_id"
  end

  create_table "service_instances", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "name"
    t.bigint "service_offering_id"
    t.bigint "service_plan_id"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_service_instances_on_archived_on"
    t.index ["service_offering_id"], name: "index_service_instances_on_service_offering_id"
    t.index ["service_plan_id"], name: "index_service_instances_on_service_plan_id"
    t.index ["source_deleted_at"], name: "index_service_instances_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_instances_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_instances_on_source_id"
  end

  create_table "service_offerings", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "name"
    t.text "description"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_service_offerings_on_archived_on"
    t.index ["source_deleted_at"], name: "index_service_offerings_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_offerings_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_offerings_on_source_id"
  end

  create_table "service_plans", force: :cascade do |t|
    t.bigint "source_id"
    t.string "source_ref"
    t.string "name"
    t.text "description"
    t.bigint "service_offering_id"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id"
    t.datetime "source_created_at"
    t.jsonb "create_json_schema"
    t.jsonb "update_json_schema"
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_service_plans_on_archived_on"
    t.index ["service_offering_id"], name: "index_service_plans_on_service_offering_id"
    t.index ["source_deleted_at"], name: "index_service_plans_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_plans_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_plans_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "external_tenant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
