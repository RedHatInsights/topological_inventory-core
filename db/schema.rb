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

ActiveRecord::Schema.define(version: 20181113182615) do

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
    t.bigint "tenant_id", null: false
    t.index ["resource_type", "resource_id"], name: "index_authentications_on_resource_type_and_resource_id"
  end

  create_table "container_groups", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.bigint "container_project_id"
    t.string "ipaddress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.bigint "container_node_id"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_on"], name: "index_container_groups_on_archived_on"
    t.index ["container_node_id"], name: "index_container_groups_on_container_node_id"
    t.index ["container_project_id"], name: "index_container_groups_on_container_project_id"
    t.index ["source_deleted_at"], name: "index_container_groups_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_groups_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_groups_on_source_id"
  end

  create_table "container_nodes", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.integer "cpus"
    t.bigint "memory"
    t.bigint "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_on"], name: "index_container_nodes_on_archived_on"
    t.index ["name"], name: "index_container_nodes_on_name"
    t.index ["source_deleted_at"], name: "index_container_nodes_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_nodes_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_nodes_on_source_id"
    t.index ["tenant_id"], name: "index_container_nodes_on_tenant_id"
  end

  create_table "container_projects", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "resource_version"
    t.string "name"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_on"], name: "index_container_projects_on_archived_on"
    t.index ["name"], name: "index_container_projects_on_name"
    t.index ["source_deleted_at"], name: "index_container_projects_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_projects_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_projects_on_source_id"
  end

  create_table "container_templates", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "resource_version"
    t.bigint "container_project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.string "name"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_on"], name: "index_container_templates_on_archived_on"
    t.index ["container_project_id"], name: "index_container_templates_on_container_project_id"
    t.index ["source_deleted_at"], name: "index_container_templates_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_templates_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_container_templates_on_source_id"
  end

  create_table "containers", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "container_group_id", null: false
    t.string "name"
    t.float "cpu_limit"
    t.float "cpu_request"
    t.bigint "memory_limit"
    t.bigint "memory_request"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_on"
    t.index ["archived_on"], name: "index_containers_on_archived_on"
    t.index ["container_group_id", "name"], name: "index_containers_on_container_group_id_and_name", unique: true
    t.index ["tenant_id"], name: "index_containers_on_tenant_id"
  end

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
  end

  create_table "service_instances", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "name"
    t.bigint "service_offering_id"
    t.bigint "service_plan_id"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.index ["archived_on"], name: "index_service_instances_on_archived_on"
    t.index ["service_offering_id"], name: "index_service_instances_on_service_offering_id"
    t.index ["service_plan_id"], name: "index_service_instances_on_service_plan_id"
    t.index ["source_deleted_at"], name: "index_service_instances_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_instances_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_instances_on_source_id"
    t.index ["source_region_id"], name: "index_service_instances_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_instances_on_subscription_id"
  end

  create_table "service_offerings", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "name"
    t.text "description"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.index ["archived_on"], name: "index_service_offerings_on_archived_on"
    t.index ["source_deleted_at"], name: "index_service_offerings_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_offerings_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_offerings_on_source_id"
    t.index ["source_region_id"], name: "index_service_offerings_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_offerings_on_subscription_id"
  end

  create_table "service_plans", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "name"
    t.text "description"
    t.bigint "service_offering_id"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.jsonb "create_json_schema"
    t.jsonb "update_json_schema"
    t.datetime "archived_on"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.index ["archived_on"], name: "index_service_plans_on_archived_on"
    t.index ["service_offering_id"], name: "index_service_plans_on_service_offering_id"
    t.index ["source_deleted_at"], name: "index_service_plans_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_plans_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_service_plans_on_source_id"
    t.index ["source_region_id"], name: "index_service_plans_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_plans_on_subscription_id"
  end

  create_table "source_regions", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "name"
    t.string "endpoint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_on"
    t.bigint "tenant_id", null: false
    t.index ["archived_on"], name: "index_source_regions_on_archived_on"
    t.index ["source_id", "source_ref"], name: "index_source_regions_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_source_regions_on_source_id"
    t.index ["tenant_id"], name: "index_source_regions_on_tenant_id"
  end

  create_table "source_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "product_name", null: false
    t.string "vendor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_source_types_on_name", unique: true
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tenant_id", null: false
    t.bigint "source_type_id"
    t.index ["source_type_id"], name: "index_sources_on_source_type_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_on"
    t.bigint "tenant_id", null: false
    t.index ["archived_on"], name: "index_subscriptions_on_archived_on"
    t.index ["source_id", "source_ref"], name: "index_subscriptions_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_subscriptions_on_source_id"
    t.index ["tenant_id"], name: "index_subscriptions_on_tenant_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "state"
    t.jsonb "context"
    t.bigint "tenant_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tasks_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "external_tenant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vms", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref"
    t.string "uuid"
    t.string "vendor"
    t.string "name"
    t.string "hostname"
    t.string "description"
    t.string "power_state"
    t.bigint "cpus"
    t.bigint "memory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.index ["archived_at"], name: "index_vms_on_archived_at"
    t.index ["source_id", "source_ref"], name: "index_vms_on_source_id_and_source_ref", unique: true
    t.index ["source_id"], name: "index_vms_on_source_id"
    t.index ["tenant_id"], name: "index_vms_on_tenant_id"
  end

  add_foreign_key "authentications", "tenants", on_delete: :cascade
  add_foreign_key "container_groups", "container_nodes", on_delete: :cascade
  add_foreign_key "container_groups", "container_projects", on_delete: :cascade
  add_foreign_key "container_groups", "sources", on_delete: :cascade
  add_foreign_key "container_groups", "tenants", on_delete: :cascade
  add_foreign_key "container_nodes", "sources", on_delete: :cascade
  add_foreign_key "container_nodes", "tenants", on_delete: :cascade
  add_foreign_key "container_projects", "sources", on_delete: :cascade
  add_foreign_key "container_projects", "tenants", on_delete: :cascade
  add_foreign_key "container_templates", "container_projects", on_delete: :cascade
  add_foreign_key "container_templates", "sources", on_delete: :cascade
  add_foreign_key "container_templates", "tenants", on_delete: :cascade
  add_foreign_key "containers", "container_groups", on_delete: :cascade
  add_foreign_key "containers", "tenants", on_delete: :cascade
  add_foreign_key "endpoints", "sources", on_delete: :cascade
  add_foreign_key "endpoints", "tenants", on_delete: :cascade
  add_foreign_key "service_instances", "service_offerings", on_delete: :nullify
  add_foreign_key "service_instances", "service_plans", on_delete: :nullify
  add_foreign_key "service_instances", "source_regions", on_delete: :cascade
  add_foreign_key "service_instances", "sources", on_delete: :cascade
  add_foreign_key "service_instances", "subscriptions", on_delete: :cascade
  add_foreign_key "service_instances", "tenants", on_delete: :cascade
  add_foreign_key "service_offerings", "source_regions", on_delete: :cascade
  add_foreign_key "service_offerings", "sources", on_delete: :cascade
  add_foreign_key "service_offerings", "subscriptions", on_delete: :cascade
  add_foreign_key "service_offerings", "tenants", on_delete: :cascade
  add_foreign_key "service_plans", "service_offerings", on_delete: :cascade
  add_foreign_key "service_plans", "source_regions", on_delete: :cascade
  add_foreign_key "service_plans", "sources", on_delete: :cascade
  add_foreign_key "service_plans", "subscriptions", on_delete: :cascade
  add_foreign_key "service_plans", "tenants", on_delete: :cascade
  add_foreign_key "source_regions", "sources", on_delete: :cascade
  add_foreign_key "source_regions", "tenants", on_delete: :cascade
  add_foreign_key "sources", "source_types", on_delete: :cascade
  add_foreign_key "sources", "tenants", on_delete: :cascade
  add_foreign_key "subscriptions", "sources", on_delete: :cascade
  add_foreign_key "subscriptions", "tenants", on_delete: :cascade
  add_foreign_key "vms", "sources", on_delete: :cascade
  add_foreign_key "vms", "tenants", on_delete: :cascade
end
