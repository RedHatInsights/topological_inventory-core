class AddIpaddressesSubnetsAndNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :networks, id: :bigserial, force: :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :name
      t.string :cidr
      t.string :status

      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    create_table :subnets, id: :bigserial, force: :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.references :network, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :name
      t.string :cidr
      t.string :status

      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    create_table :ipaddresses, id: :bigserial, force: :cascade do |t|
      t.references :network_adapter, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :subnet, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :ipaddress

      t.datetime :last_seen_at
      t.index :last_seen_at

      t.index %i[network_adapter_id subnet_id ipaddress], :unique => true,
              :name                                               => "ipaddresses_uniq_index_with_subnet_id"
      t.index %i[network_adapter_id ipaddress], :unique => true, :where => "subnet_id IS NULL",
              :name                                     => "ipaddresses_uniq_index_without_subnet_id"
    end

    create_table :floating_ips, id: :bigserial, force: :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.references :network_adapter, :index => true, :null => true, :foreign_key => {:on_delete => :nullify}
      t.references :network, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :ipaddress
      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    create_table :security_groups, id: :bigserial, force: :cascade do |t|
      t.references :tenant, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source_region, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :subscription, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}
      t.references :orchestration_stack, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.references :network, :index => true, :null => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref, :null => false
      t.string :name
      t.string :description
      t.jsonb :extra

      t.datetime :resource_timestamp
      t.jsonb :resource_timestamps, default: {}
      t.datetime :resource_timestamps_max

      t.timestamps
      t.datetime :archived_at
      t.datetime :source_created_at
      t.datetime :source_deleted_at
      t.datetime :last_seen_at

      t.index :archived_at
      t.index :last_seen_at

      t.index %i[source_id source_ref], :unique => true
    end

    create_table :vm_security_groups, id: :bigserial, force: :cascade do |t|
      t.references :vm, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :security_group, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index :last_seen_at
      t.index %i[vm_id security_group_id], :unique => true
    end

    create_table :network_adapter_tags, id: :serial, force: :cascade do |t|
      t.references :tag,  :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network_adapter, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id network_adapter_id], unique: true
    end

    create_table :network_tags, id: :serial, force: :cascade do |t|
      t.references :tag,  :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :network, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id network_id], unique: true
    end

    create_table :subnet_tags, id: :serial, force: :cascade do |t|
      t.references :tag,  :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :subnet, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id subnet_id], unique: true
    end

    create_table :security_group_tags, id: :serial, force: :cascade do |t|
      t.references :tag,  :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :security_group, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id security_group_id], unique: true
    end

    create_table :floating_ip_tags, id: :serial, force: :cascade do |t|
      t.references :tag,  :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :floating_ip, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.datetime :last_seen_at

      t.index %i[last_seen_at]
      t.index %i[tag_id floating_ip_id], unique: true
    end
  end
end
