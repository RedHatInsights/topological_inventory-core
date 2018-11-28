class AddContainerImages < ActiveRecord::Migration[5.1]
  def change
    create_table :container_images, :id => :bigserial do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :source, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string     :source_ref
      t.string     :resource_version
      t.string     :name
      t.string     :tag

      t.timestamps
      t.datetime   :archived_on
      t.datetime   :last_seen_at
      t.datetime   :source_deleted_at
      t.datetime   :source_created_at

      t.datetime   :resource_timestamp
      t.jsonb      :resource_timestamps, :default => {}
      t.datetime   :resource_timestamps_max

      t.index [:source_id, :source_ref], :unique => true
      t.index :archived_on
    end

    add_reference :containers, :container_image, :index => true, :foreign_key => {:on_delete => :nullify}
  end
end
