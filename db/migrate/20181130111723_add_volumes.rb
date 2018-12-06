class AddVolumes < ActiveRecord::Migration[5.1]
  def change
    create_table :volume_types, :id => :bigserial do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref
      t.string :name
      t.text   :description
      t.jsonb  :extra

      t.timestamps
      t.datetime :archived_at
      t.datetime :last_seen_at

      t.index [:source_id, :source_ref], :unique => true
      t.index :archived_at
    end

    create_table :volumes, :id => :bigserial do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source_region, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
      t.references :volume_type, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}

      t.string :source_ref
      t.string :name
      t.string :state
      t.bigint :size
      t.jsonb  :extra

      t.timestamps
      t.datetime :archived_at
      t.datetime :last_seen_at
      t.datetime :source_deleted_at
      t.datetime :source_created_at

      t.datetime :resource_timestamp
      t.jsonb    :resource_timestamps, :default => {}
      t.datetime :resource_timestamps_max

      t.index [:source_id, :source_ref], :unique => true
      t.index :archived_at
    end

    create_table :volume_attachments, :id => :bigserial do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :vm, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :volume, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string :device
      t.string :state

      t.index [:vm_id, :volume_id], :unique => true
    end
  end
end
