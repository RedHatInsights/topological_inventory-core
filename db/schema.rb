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

ActiveRecord::Schema.define(version: 2019_09_26_144242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.string "resource_type", null: false
    t.bigint "resource_id", null: false
    t.string "action", null: false
    t.string "identifier", null: false
    t.string "availability", null: false
    t.datetime "last_checked_at"
    t.datetime "last_valid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id", "action", "identifier"], name: "index_on_resource_action_identifier", unique: true
  end

  create_table "cluster_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "cluster_id", null: false
    t.datetime "last_seen_at"
    t.index ["cluster_id"], name: "index_cluster_tags_on_cluster_id"
    t.index ["last_seen_at"], name: "index_cluster_tags_on_last_seen_at"
    t.index ["tag_id", "cluster_id"], name: "index_cluster_tags_on_tag_id_and_cluster_id", unique: true
  end

  create_table "clusters", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "uid_ems"
    t.string "name"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_clusters_on_archived_at"
    t.index ["last_seen_at"], name: "index_clusters_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_clusters_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_clusters_on_tenant_id"
    t.index ["uid_ems"], name: "index_clusters_on_uid_ems"
  end

  create_table "container_group_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "container_group_id", null: false
    t.datetime "last_seen_at"
    t.index ["container_group_id", "tag_id"], name: "uniq_index_on_container_group_id_tag_id", unique: true
    t.index ["last_seen_at"], name: "index_container_group_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_container_group_tags_on_tag_id"
  end

  create_table "container_groups", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
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
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_container_groups_on_archived_at"
    t.index ["container_node_id"], name: "index_container_groups_on_container_node_id"
    t.index ["container_project_id"], name: "index_container_groups_on_container_project_id"
    t.index ["last_seen_at"], name: "index_container_groups_on_last_seen_at"
    t.index ["source_deleted_at"], name: "index_container_groups_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_groups_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_groups_on_tenant_id"
  end

  create_table "container_image_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "container_image_id", null: false
    t.datetime "last_seen_at"
    t.index ["container_image_id", "tag_id"], name: "uniq_index_on_container_image_id_tag_id", unique: true
    t.index ["last_seen_at"], name: "index_container_image_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_container_image_tags_on_tag_id"
  end

  create_table "container_images", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "resource_version"
    t.string "name"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "last_seen_at"
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_at"], name: "index_container_images_on_archived_at"
    t.index ["last_seen_at"], name: "index_container_images_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_container_images_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_images_on_tenant_id"
  end

  create_table "container_node_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "container_node_id", null: false
    t.datetime "last_seen_at"
    t.index ["container_node_id", "tag_id"], name: "uniq_index_on_container_node_id_tag_id", unique: true
    t.index ["last_seen_at"], name: "index_container_node_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_container_node_tags_on_tag_id"
  end

  create_table "container_nodes", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "resource_version"
    t.string "name"
    t.integer "cpus"
    t.bigint "memory"
    t.bigint "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "last_seen_at"
    t.string "lives_on_type"
    t.bigint "lives_on_id"
    t.integer "pods"
    t.bigint "allocatable_memory"
    t.float "allocatable_cpus"
    t.integer "allocatable_pods"
    t.jsonb "conditions"
    t.jsonb "addresses"
    t.jsonb "node_info"
    t.index ["archived_at"], name: "index_container_nodes_on_archived_at"
    t.index ["last_seen_at"], name: "index_container_nodes_on_last_seen_at"
    t.index ["lives_on_type", "lives_on_id"], name: "index_container_nodes_on_lives_on_type_and_lives_on_id"
    t.index ["name"], name: "index_container_nodes_on_name"
    t.index ["source_deleted_at"], name: "index_container_nodes_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_nodes_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_nodes_on_tenant_id"
  end

  create_table "container_project_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "container_project_id", null: false
    t.datetime "last_seen_at"
    t.index ["container_project_id", "tag_id"], name: "uniq_index_on_container_project_id_tag_id", unique: true
    t.index ["last_seen_at"], name: "index_container_project_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_container_project_tags_on_tag_id"
  end

  create_table "container_projects", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "resource_version"
    t.string "name"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "last_seen_at"
    t.string "status_phase"
    t.index ["archived_at"], name: "index_container_projects_on_archived_at"
    t.index ["last_seen_at"], name: "index_container_projects_on_last_seen_at"
    t.index ["name"], name: "index_container_projects_on_name"
    t.index ["source_deleted_at"], name: "index_container_projects_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_projects_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_projects_on_tenant_id"
  end

  create_table "container_resource_quotas", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "container_project_id"
    t.string "source_ref", null: false
    t.string "resource_version"
    t.string "name"
    t.jsonb "status"
    t.jsonb "spec"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "last_seen_at"
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.index ["archived_at"], name: "index_container_resource_quotas_on_archived_at"
    t.index ["container_project_id"], name: "index_container_resource_quotas_on_container_project_id"
    t.index ["last_seen_at"], name: "index_container_resource_quotas_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_container_resource_quotas_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_resource_quotas_on_tenant_id"
  end

  create_table "container_template_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "container_template_id", null: false
    t.datetime "last_seen_at"
    t.index ["container_template_id", "tag_id"], name: "uniq_index_on_container_template_id_tag_id", unique: true
    t.index ["last_seen_at"], name: "index_container_template_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_container_template_tags_on_tag_id"
  end

  create_table "container_templates", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "resource_version"
    t.bigint "container_project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.string "name"
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_container_templates_on_archived_at"
    t.index ["container_project_id"], name: "index_container_templates_on_container_project_id"
    t.index ["last_seen_at"], name: "index_container_templates_on_last_seen_at"
    t.index ["source_deleted_at"], name: "index_container_templates_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_container_templates_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_container_templates_on_tenant_id"
  end

  create_table "containers", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "container_group_id", null: false
    t.string "name", null: false
    t.float "cpu_limit"
    t.float "cpu_request"
    t.bigint "memory_limit"
    t.bigint "memory_request"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "container_image_id"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_containers_on_archived_at"
    t.index ["container_group_id", "name"], name: "index_containers_on_container_group_id_and_name", unique: true
    t.index ["container_image_id"], name: "index_containers_on_container_image_id"
    t.index ["last_seen_at"], name: "index_containers_on_last_seen_at"
    t.index ["tenant_id"], name: "index_containers_on_tenant_id"
  end

  create_table "datastore_mounts", force: :cascade do |t|
    t.bigint "datastore_id", null: false
    t.bigint "host_id", null: false
    t.boolean "read_only"
    t.boolean "accessible"
    t.datetime "last_seen_at"
    t.index ["datastore_id", "host_id"], name: "index_datastore_mounts_on_datastore_id_and_host_id", unique: true
    t.index ["host_id"], name: "index_datastore_mounts_on_host_id"
    t.index ["last_seen_at"], name: "index_datastore_mounts_on_last_seen_at"
  end

  create_table "datastore_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "datastore_id", null: false
    t.datetime "last_seen_at"
    t.index ["datastore_id"], name: "index_datastore_tags_on_datastore_id"
    t.index ["last_seen_at"], name: "index_datastore_tags_on_last_seen_at"
    t.index ["tag_id", "datastore_id"], name: "index_datastore_tags_on_tag_id_and_datastore_id", unique: true
  end

  create_table "datastores", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.string "location"
    t.bigint "total_space"
    t.bigint "free_space"
    t.string "status"
    t.boolean "accessible"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_datastores_on_archived_at"
    t.index ["last_seen_at"], name: "index_datastores_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_datastores_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_datastores_on_tenant_id"
  end

  create_table "flavors", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "last_seen_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "disk_size"
    t.bigint "memory"
    t.integer "disk_count"
    t.integer "cpus"
    t.index ["archived_at"], name: "index_flavors_on_archived_at"
    t.index ["last_seen_at"], name: "index_flavors_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_flavors_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_flavors_on_tenant_id"
  end

  create_table "host_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "host_id", null: false
    t.datetime "last_seen_at"
    t.index ["host_id"], name: "index_host_tags_on_host_id"
    t.index ["last_seen_at"], name: "index_host_tags_on_last_seen_at"
    t.index ["tag_id", "host_id"], name: "index_host_tags_on_tag_id_and_host_id", unique: true
  end

  create_table "hosts", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "cluster_id"
    t.string "source_ref", null: false
    t.string "uid_ems"
    t.string "name"
    t.string "hostname"
    t.string "description"
    t.string "power_state"
    t.bigint "cpus"
    t.bigint "memory"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_hosts_on_archived_at"
    t.index ["cluster_id"], name: "index_hosts_on_cluster_id"
    t.index ["last_seen_at"], name: "index_hosts_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_hosts_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_hosts_on_tenant_id"
    t.index ["uid_ems"], name: "index_hosts_on_uid_ems"
  end

  create_table "ipaddress_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "ipaddress_id", null: false
    t.datetime "last_seen_at"
    t.index ["ipaddress_id"], name: "index_ipaddress_tags_on_ipaddress_id"
    t.index ["last_seen_at"], name: "index_ipaddress_tags_on_last_seen_at"
    t.index ["tag_id", "ipaddress_id"], name: "index_ipaddress_tags_on_tag_id_and_ipaddress_id", unique: true
  end

  create_table "ipaddresses", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "orchestration_stack_id"
    t.bigint "network_adapter_id"
    t.bigint "subnet_id"
    t.string "source_ref", null: false
    t.string "kind", default: "private", null: false
    t.string "ipaddress"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_ipaddresses_on_archived_at"
    t.index ["last_seen_at"], name: "index_ipaddresses_on_last_seen_at"
    t.index ["network_adapter_id"], name: "index_ipaddresses_on_network_adapter_id"
    t.index ["orchestration_stack_id"], name: "index_ipaddresses_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_ipaddresses_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_ipaddresses_on_source_region_id"
    t.index ["subnet_id"], name: "index_ipaddresses_on_subnet_id"
    t.index ["subscription_id"], name: "index_ipaddresses_on_subscription_id"
    t.index ["tenant_id"], name: "index_ipaddresses_on_tenant_id"
  end

  create_table "network_adapter_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "network_adapter_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_network_adapter_tags_on_last_seen_at"
    t.index ["network_adapter_id"], name: "index_network_adapter_tags_on_network_adapter_id"
    t.index ["tag_id", "network_adapter_id"], name: "index_network_adapter_tags_on_tag_id_and_network_adapter_id", unique: true
  end

  create_table "network_adapters", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "source_ref", null: false
    t.string "mac_address"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.bigint "source_id", null: false
    t.bigint "orchestration_stack_id"
    t.string "device_type"
    t.bigint "device_id"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.index ["archived_at"], name: "index_network_adapters_on_archived_at"
    t.index ["device_type", "device_id"], name: "index_network_adapters_on_device_type_and_device_id"
    t.index ["last_seen_at"], name: "index_network_adapters_on_last_seen_at"
    t.index ["orchestration_stack_id"], name: "index_network_adapters_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_network_adapters_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_network_adapters_on_source_region_id"
    t.index ["subscription_id"], name: "index_network_adapters_on_subscription_id"
    t.index ["tenant_id"], name: "index_network_adapters_on_tenant_id"
  end

  create_table "network_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "network_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_network_tags_on_last_seen_at"
    t.index ["network_id"], name: "index_network_tags_on_network_id"
    t.index ["tag_id", "network_id"], name: "index_network_tags_on_tag_id_and_network_id", unique: true
  end

  create_table "networks", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "orchestration_stack_id"
    t.string "source_ref", null: false
    t.string "name"
    t.string "cidr"
    t.string "status"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_networks_on_archived_at"
    t.index ["last_seen_at"], name: "index_networks_on_last_seen_at"
    t.index ["orchestration_stack_id"], name: "index_networks_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_networks_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_networks_on_source_region_id"
    t.index ["subscription_id"], name: "index_networks_on_subscription_id"
    t.index ["tenant_id"], name: "index_networks_on_tenant_id"
  end

  create_table "orchestration_stacks", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.string "description"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "parent_orchestration_stack_id"
    t.index ["archived_at"], name: "index_orchestration_stacks_on_archived_at"
    t.index ["last_seen_at"], name: "index_orchestration_stacks_on_last_seen_at"
    t.index ["parent_orchestration_stack_id"], name: "index_orchestration_stacks_on_parent_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_orchestration_stacks_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_orchestration_stacks_on_source_region_id"
    t.index ["subscription_id"], name: "index_orchestration_stacks_on_subscription_id"
    t.index ["tenant_id"], name: "index_orchestration_stacks_on_tenant_id"
  end

  create_table "refresh_state_parts", force: :cascade do |t|
    t.bigint "refresh_state_id", null: false
    t.bigint "tenant_id", null: false
    t.uuid "uuid", null: false
    t.string "status"
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["refresh_state_id", "uuid"], name: "index_refresh_state_parts_on_refresh_state_id_and_uuid", unique: true
    t.index ["tenant_id"], name: "index_refresh_state_parts_on_tenant_id"
  end

  create_table "refresh_states", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "tenant_id", null: false
    t.uuid "uuid", null: false
    t.string "status"
    t.integer "total_parts"
    t.jsonb "sweep_scope"
    t.integer "sweep_retry_count", default: 0
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id", "uuid"], name: "index_refresh_states_on_source_id_and_uuid", unique: true
    t.index ["tenant_id"], name: "index_refresh_states_on_tenant_id"
  end

  create_table "reservation_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "reservation_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_reservation_tags_on_last_seen_at"
    t.index ["reservation_id"], name: "index_reservation_tags_on_reservation_id"
    t.index ["tag_id", "reservation_id"], name: "index_reservation_tags_on_tag_id_and_reservation_id", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "flavor_id"
    t.string "source_ref", null: false
    t.string "state"
    t.datetime "start"
    t.datetime "end"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_reservations_on_archived_at"
    t.index ["flavor_id"], name: "index_reservations_on_flavor_id"
    t.index ["last_seen_at"], name: "index_reservations_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_reservations_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_reservations_on_source_region_id"
    t.index ["subscription_id"], name: "index_reservations_on_subscription_id"
    t.index ["tenant_id"], name: "index_reservations_on_tenant_id"
  end

  create_table "security_group_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "security_group_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_security_group_tags_on_last_seen_at"
    t.index ["security_group_id"], name: "index_security_group_tags_on_security_group_id"
    t.index ["tag_id", "security_group_id"], name: "index_security_group_tags_on_tag_id_and_security_group_id", unique: true
  end

  create_table "security_groups", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "orchestration_stack_id"
    t.bigint "network_id"
    t.string "source_ref", null: false
    t.string "name"
    t.string "description"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_security_groups_on_archived_at"
    t.index ["last_seen_at"], name: "index_security_groups_on_last_seen_at"
    t.index ["network_id"], name: "index_security_groups_on_network_id"
    t.index ["orchestration_stack_id"], name: "index_security_groups_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_security_groups_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_security_groups_on_source_region_id"
    t.index ["subscription_id"], name: "index_security_groups_on_subscription_id"
    t.index ["tenant_id"], name: "index_security_groups_on_tenant_id"
  end

  create_table "service_instances", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.bigint "service_offering_id"
    t.bigint "service_plan_id"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.datetime "last_seen_at"
    t.string "external_url"
    t.index ["archived_at"], name: "index_service_instances_on_archived_at"
    t.index ["last_seen_at"], name: "index_service_instances_on_last_seen_at"
    t.index ["service_offering_id"], name: "index_service_instances_on_service_offering_id"
    t.index ["service_plan_id"], name: "index_service_instances_on_service_plan_id"
    t.index ["source_deleted_at"], name: "index_service_instances_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_instances_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_service_instances_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_instances_on_subscription_id"
    t.index ["tenant_id"], name: "index_service_instances_on_tenant_id"
  end

  create_table "service_inventories", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.string "inventory_type"
    t.text "description"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_service_inventories_on_archived_at"
    t.index ["last_seen_at"], name: "index_service_inventories_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_service_inventories_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_service_inventories_on_tenant_id"
  end

  create_table "service_offering_icons", id: :serial, force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.binary "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_service_offering_icons_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_service_offering_icons_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_service_offering_icons_on_tenant_id"
  end

  create_table "service_offering_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "service_offering_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_service_offering_tags_on_last_seen_at"
    t.index ["service_offering_id", "tag_id"], name: "uniq_index_on_service_offering_id_tag_id", unique: true
    t.index ["tag_id"], name: "index_service_offering_tags_on_tag_id"
  end

  create_table "service_offerings", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.text "description"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_deleted_at"
    t.bigint "tenant_id", null: false
    t.datetime "source_created_at"
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.datetime "last_seen_at"
    t.string "display_name"
    t.string "documentation_url"
    t.text "long_description"
    t.string "distributor"
    t.string "support_url"
    t.bigint "service_offering_icon_id"
    t.index ["archived_at"], name: "index_service_offerings_on_archived_at"
    t.index ["last_seen_at"], name: "index_service_offerings_on_last_seen_at"
    t.index ["service_offering_icon_id"], name: "index_service_offerings_on_service_offering_icon_id"
    t.index ["source_deleted_at"], name: "index_service_offerings_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_offerings_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_service_offerings_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_offerings_on_subscription_id"
    t.index ["tenant_id"], name: "index_service_offerings_on_tenant_id"
  end

  create_table "service_plans", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
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
    t.datetime "archived_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.datetime "last_seen_at"
    t.string "resource_version"
    t.index ["archived_at"], name: "index_service_plans_on_archived_at"
    t.index ["last_seen_at"], name: "index_service_plans_on_last_seen_at"
    t.index ["service_offering_id"], name: "index_service_plans_on_service_offering_id"
    t.index ["source_deleted_at"], name: "index_service_plans_on_source_deleted_at"
    t.index ["source_id", "source_ref"], name: "index_service_plans_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_service_plans_on_source_region_id"
    t.index ["subscription_id"], name: "index_service_plans_on_subscription_id"
    t.index ["tenant_id"], name: "index_service_plans_on_tenant_id"
  end

  create_table "source_regions", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.string "endpoint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "tenant_id", null: false
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_source_regions_on_archived_at"
    t.index ["last_seen_at"], name: "index_source_regions_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_source_regions_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_source_regions_on_tenant_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tenant_id", null: false
    t.string "refresh_status"
    t.index ["tenant_id"], name: "index_sources_on_tenant_id"
    t.index ["uid"], name: "index_sources_on_uid", unique: true
  end

  create_table "subnet_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "subnet_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_subnet_tags_on_last_seen_at"
    t.index ["subnet_id"], name: "index_subnet_tags_on_subnet_id"
    t.index ["tag_id", "subnet_id"], name: "index_subnet_tags_on_tag_id_and_subnet_id", unique: true
  end

  create_table "subnets", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.bigint "orchestration_stack_id"
    t.bigint "network_id"
    t.string "source_ref", null: false
    t.string "name"
    t.string "cidr"
    t.string "status"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_subnets_on_archived_at"
    t.index ["last_seen_at"], name: "index_subnets_on_last_seen_at"
    t.index ["network_id"], name: "index_subnets_on_network_id"
    t.index ["orchestration_stack_id"], name: "index_subnets_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_subnets_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_subnets_on_source_region_id"
    t.index ["subscription_id"], name: "index_subnets_on_subscription_id"
    t.index ["tenant_id"], name: "index_subnets_on_tenant_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "tenant_id", null: false
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_subscriptions_on_archived_at"
    t.index ["last_seen_at"], name: "index_subscriptions_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_subscriptions_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_subscriptions_on_tenant_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "name", null: false
    t.string "namespace", default: "", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.string "value", default: "", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_tags_on_last_seen_at"
    t.index ["tenant_id", "namespace", "name", "value"], name: "index_tags_on_tenant_id_and_namespace_and_name_and_value", unique: true
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
    t.string "external_tenant", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_tenant"], name: "index_tenants_on_external_tenant", unique: true
  end

  create_table "vm_security_groups", force: :cascade do |t|
    t.bigint "vm_id", null: false
    t.bigint "security_group_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_vm_security_groups_on_last_seen_at"
    t.index ["security_group_id"], name: "index_vm_security_groups_on_security_group_id"
    t.index ["vm_id", "security_group_id"], name: "index_vm_security_groups_on_vm_id_and_security_group_id", unique: true
  end

  create_table "vm_tags", id: :serial, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "vm_id", null: false
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_vm_tags_on_last_seen_at"
    t.index ["tag_id"], name: "index_vm_tags_on_tag_id"
    t.index ["vm_id", "tag_id"], name: "uniq_index_on_vm_id_tag_id", unique: true
  end

  create_table "vms", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "uid_ems"
    t.string "name"
    t.string "hostname"
    t.string "description"
    t.string "power_state"
    t.bigint "cpus"
    t.bigint "memory"
    t.jsonb "extra"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "source_created_at"
    t.datetime "source_deleted_at"
    t.bigint "orchestration_stack_id"
    t.datetime "last_seen_at"
    t.bigint "flavor_id"
    t.uuid "host_inventory_uuid"
    t.jsonb "mac_addresses"
    t.bigint "source_region_id"
    t.bigint "subscription_id"
    t.index ["archived_at"], name: "index_vms_on_archived_at"
    t.index ["flavor_id"], name: "index_vms_on_flavor_id"
    t.index ["host_inventory_uuid"], name: "index_vms_on_host_inventory_uuid"
    t.index ["last_seen_at"], name: "index_vms_on_last_seen_at"
    t.index ["orchestration_stack_id"], name: "index_vms_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_vms_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_vms_on_source_region_id"
    t.index ["subscription_id"], name: "index_vms_on_subscription_id"
    t.index ["tenant_id"], name: "index_vms_on_tenant_id"
    t.index ["uid_ems"], name: "index_vms_on_uid_ems"
  end

  create_table "volume_attachments", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "vm_id", null: false
    t.bigint "volume_id", null: false
    t.string "device"
    t.string "state"
    t.datetime "last_seen_at"
    t.index ["last_seen_at"], name: "index_volume_attachments_on_last_seen_at"
    t.index ["tenant_id"], name: "index_volume_attachments_on_tenant_id"
    t.index ["vm_id", "volume_id"], name: "index_volume_attachments_on_vm_id_and_volume_id", unique: true
    t.index ["volume_id"], name: "index_volume_attachments_on_volume_id"
  end

  create_table "volume_types", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.string "source_ref", null: false
    t.string "name"
    t.text "description"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "last_seen_at"
    t.index ["archived_at"], name: "index_volume_types_on_archived_at"
    t.index ["last_seen_at"], name: "index_volume_types_on_last_seen_at"
    t.index ["source_id", "source_ref"], name: "index_volume_types_on_source_id_and_source_ref", unique: true
    t.index ["tenant_id"], name: "index_volume_types_on_tenant_id"
  end

  create_table "volumes", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "source_id", null: false
    t.bigint "source_region_id"
    t.bigint "volume_type_id"
    t.string "source_ref", null: false
    t.string "name"
    t.string "state"
    t.bigint "size"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.datetime "last_seen_at"
    t.datetime "source_deleted_at"
    t.datetime "source_created_at"
    t.datetime "resource_timestamp"
    t.jsonb "resource_timestamps", default: {}
    t.datetime "resource_timestamps_max"
    t.bigint "orchestration_stack_id"
    t.bigint "subscription_id"
    t.index ["archived_at"], name: "index_volumes_on_archived_at"
    t.index ["last_seen_at"], name: "index_volumes_on_last_seen_at"
    t.index ["orchestration_stack_id"], name: "index_volumes_on_orchestration_stack_id"
    t.index ["source_id", "source_ref"], name: "index_volumes_on_source_id_and_source_ref", unique: true
    t.index ["source_region_id"], name: "index_volumes_on_source_region_id"
    t.index ["subscription_id"], name: "index_volumes_on_subscription_id"
    t.index ["tenant_id"], name: "index_volumes_on_tenant_id"
    t.index ["volume_type_id"], name: "index_volumes_on_volume_type_id"
  end

  add_foreign_key "cluster_tags", "clusters", on_delete: :cascade
  add_foreign_key "cluster_tags", "tags", on_delete: :cascade
  add_foreign_key "clusters", "sources", on_delete: :cascade
  add_foreign_key "clusters", "tenants", on_delete: :cascade
  add_foreign_key "container_group_tags", "container_groups", on_delete: :cascade
  add_foreign_key "container_group_tags", "tags", on_delete: :cascade
  add_foreign_key "container_groups", "container_nodes", on_delete: :cascade
  add_foreign_key "container_groups", "container_projects", on_delete: :cascade
  add_foreign_key "container_groups", "sources", on_delete: :cascade
  add_foreign_key "container_groups", "tenants", on_delete: :cascade
  add_foreign_key "container_image_tags", "container_images", on_delete: :cascade
  add_foreign_key "container_image_tags", "tags", on_delete: :cascade
  add_foreign_key "container_images", "sources", on_delete: :cascade
  add_foreign_key "container_images", "tenants", on_delete: :cascade
  add_foreign_key "container_node_tags", "container_nodes", on_delete: :cascade
  add_foreign_key "container_node_tags", "tags", on_delete: :cascade
  add_foreign_key "container_nodes", "sources", on_delete: :cascade
  add_foreign_key "container_nodes", "tenants", on_delete: :cascade
  add_foreign_key "container_project_tags", "container_projects", on_delete: :cascade
  add_foreign_key "container_project_tags", "tags", on_delete: :cascade
  add_foreign_key "container_projects", "sources", on_delete: :cascade
  add_foreign_key "container_projects", "tenants", on_delete: :cascade
  add_foreign_key "container_resource_quotas", "container_projects", on_delete: :cascade
  add_foreign_key "container_resource_quotas", "sources", on_delete: :cascade
  add_foreign_key "container_resource_quotas", "tenants", on_delete: :cascade
  add_foreign_key "container_template_tags", "container_templates", on_delete: :cascade
  add_foreign_key "container_template_tags", "tags", on_delete: :cascade
  add_foreign_key "container_templates", "container_projects", on_delete: :cascade
  add_foreign_key "container_templates", "sources", on_delete: :cascade
  add_foreign_key "container_templates", "tenants", on_delete: :cascade
  add_foreign_key "containers", "container_groups", on_delete: :cascade
  add_foreign_key "containers", "container_images", on_delete: :nullify
  add_foreign_key "containers", "tenants", on_delete: :cascade
  add_foreign_key "datastore_mounts", "datastores", on_delete: :cascade
  add_foreign_key "datastore_mounts", "hosts", on_delete: :cascade
  add_foreign_key "datastore_tags", "datastores", on_delete: :cascade
  add_foreign_key "datastore_tags", "tags", on_delete: :cascade
  add_foreign_key "datastores", "sources", on_delete: :cascade
  add_foreign_key "datastores", "tenants", on_delete: :cascade
  add_foreign_key "flavors", "sources", on_delete: :cascade
  add_foreign_key "flavors", "tenants", on_delete: :cascade
  add_foreign_key "host_tags", "hosts", on_delete: :cascade
  add_foreign_key "host_tags", "tags", on_delete: :cascade
  add_foreign_key "hosts", "clusters", on_delete: :nullify
  add_foreign_key "hosts", "sources", on_delete: :cascade
  add_foreign_key "hosts", "tenants", on_delete: :cascade
  add_foreign_key "ipaddress_tags", "ipaddresses", on_delete: :cascade
  add_foreign_key "ipaddress_tags", "tags", on_delete: :cascade
  add_foreign_key "ipaddresses", "network_adapters", on_delete: :cascade
  add_foreign_key "ipaddresses", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "ipaddresses", "source_regions", on_delete: :cascade
  add_foreign_key "ipaddresses", "sources", on_delete: :cascade
  add_foreign_key "ipaddresses", "subnets", on_delete: :cascade
  add_foreign_key "ipaddresses", "subscriptions", on_delete: :cascade
  add_foreign_key "ipaddresses", "tenants", on_delete: :cascade
  add_foreign_key "network_adapter_tags", "network_adapters", on_delete: :cascade
  add_foreign_key "network_adapter_tags", "tags", on_delete: :cascade
  add_foreign_key "network_adapters", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "network_adapters", "source_regions", on_delete: :cascade
  add_foreign_key "network_adapters", "sources", on_delete: :cascade
  add_foreign_key "network_adapters", "subscriptions", on_delete: :cascade
  add_foreign_key "network_adapters", "tenants", on_delete: :cascade
  add_foreign_key "network_tags", "networks", on_delete: :cascade
  add_foreign_key "network_tags", "tags", on_delete: :cascade
  add_foreign_key "networks", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "networks", "source_regions", on_delete: :cascade
  add_foreign_key "networks", "sources", on_delete: :cascade
  add_foreign_key "networks", "subscriptions", on_delete: :cascade
  add_foreign_key "networks", "tenants", on_delete: :cascade
  add_foreign_key "orchestration_stacks", "orchestration_stacks", column: "parent_orchestration_stack_id", on_delete: :cascade
  add_foreign_key "orchestration_stacks", "source_regions", on_delete: :cascade
  add_foreign_key "orchestration_stacks", "sources", on_delete: :cascade
  add_foreign_key "orchestration_stacks", "subscriptions", on_delete: :cascade
  add_foreign_key "orchestration_stacks", "tenants", on_delete: :cascade
  add_foreign_key "refresh_state_parts", "refresh_states", on_delete: :cascade
  add_foreign_key "refresh_state_parts", "tenants", on_delete: :cascade
  add_foreign_key "refresh_states", "sources", on_delete: :cascade
  add_foreign_key "refresh_states", "tenants", on_delete: :cascade
  add_foreign_key "reservation_tags", "reservations", on_delete: :cascade
  add_foreign_key "reservation_tags", "tags", on_delete: :cascade
  add_foreign_key "reservations", "flavors", on_delete: :cascade
  add_foreign_key "reservations", "source_regions", on_delete: :cascade
  add_foreign_key "reservations", "sources", on_delete: :cascade
  add_foreign_key "reservations", "subscriptions", on_delete: :cascade
  add_foreign_key "reservations", "tenants", on_delete: :cascade
  add_foreign_key "security_group_tags", "security_groups", on_delete: :cascade
  add_foreign_key "security_group_tags", "tags", on_delete: :cascade
  add_foreign_key "security_groups", "networks", on_delete: :cascade
  add_foreign_key "security_groups", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "security_groups", "source_regions", on_delete: :cascade
  add_foreign_key "security_groups", "sources", on_delete: :cascade
  add_foreign_key "security_groups", "subscriptions", on_delete: :cascade
  add_foreign_key "security_groups", "tenants", on_delete: :cascade
  add_foreign_key "service_instances", "service_offerings", on_delete: :nullify
  add_foreign_key "service_instances", "service_plans", on_delete: :nullify
  add_foreign_key "service_instances", "source_regions", on_delete: :cascade
  add_foreign_key "service_instances", "sources", on_delete: :cascade
  add_foreign_key "service_instances", "subscriptions", on_delete: :cascade
  add_foreign_key "service_instances", "tenants", on_delete: :cascade
  add_foreign_key "service_inventories", "sources", on_delete: :cascade
  add_foreign_key "service_inventories", "tenants", on_delete: :cascade
  add_foreign_key "service_offering_icons", "sources", on_delete: :cascade
  add_foreign_key "service_offering_icons", "tenants", on_delete: :cascade
  add_foreign_key "service_offering_tags", "service_offerings", on_delete: :cascade
  add_foreign_key "service_offering_tags", "tags", on_delete: :cascade
  add_foreign_key "service_offerings", "service_offering_icons", on_delete: :nullify
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
  add_foreign_key "sources", "tenants", on_delete: :cascade
  add_foreign_key "subnet_tags", "subnets", on_delete: :cascade
  add_foreign_key "subnet_tags", "tags", on_delete: :cascade
  add_foreign_key "subnets", "networks", on_delete: :cascade
  add_foreign_key "subnets", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "subnets", "source_regions", on_delete: :cascade
  add_foreign_key "subnets", "sources", on_delete: :cascade
  add_foreign_key "subnets", "subscriptions", on_delete: :cascade
  add_foreign_key "subnets", "tenants", on_delete: :cascade
  add_foreign_key "subscriptions", "sources", on_delete: :cascade
  add_foreign_key "subscriptions", "tenants", on_delete: :cascade
  add_foreign_key "tags", "tenants", on_delete: :cascade
  add_foreign_key "tasks", "tenants", on_delete: :cascade
  add_foreign_key "vm_security_groups", "security_groups", on_delete: :cascade
  add_foreign_key "vm_security_groups", "vms", on_delete: :cascade
  add_foreign_key "vm_tags", "tags", on_delete: :cascade
  add_foreign_key "vm_tags", "vms", on_delete: :cascade
  add_foreign_key "vms", "flavors", on_delete: :nullify
  add_foreign_key "vms", "orchestration_stacks", on_delete: :nullify
  add_foreign_key "vms", "source_regions", on_delete: :cascade
  add_foreign_key "vms", "sources", on_delete: :cascade
  add_foreign_key "vms", "subscriptions", on_delete: :cascade
  add_foreign_key "vms", "tenants", on_delete: :cascade
  add_foreign_key "volume_attachments", "tenants", on_delete: :cascade
  add_foreign_key "volume_attachments", "vms", on_delete: :cascade
  add_foreign_key "volume_attachments", "volumes", on_delete: :cascade
  add_foreign_key "volume_types", "sources", on_delete: :cascade
  add_foreign_key "volume_types", "tenants", on_delete: :cascade
  add_foreign_key "volumes", "orchestration_stacks", on_delete: :cascade
  add_foreign_key "volumes", "source_regions", on_delete: :cascade
  add_foreign_key "volumes", "sources", on_delete: :cascade
  add_foreign_key "volumes", "subscriptions", on_delete: :cascade
  add_foreign_key "volumes", "tenants", on_delete: :cascade
  add_foreign_key "volumes", "volume_types", on_delete: :cascade
end
