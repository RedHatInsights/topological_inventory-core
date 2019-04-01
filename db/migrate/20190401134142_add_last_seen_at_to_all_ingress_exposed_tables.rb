class AddLastSeenAtToAllIngressExposedTables < ActiveRecord::Migration[5.2]
  def change
    add_column :vm_tags, :last_seen_at, :datetime
    add_index :vm_tags, :last_seen_at

    add_column :volume_attachments, :last_seen_at, :datetime
    add_index :volume_attachments, :last_seen_at

    add_column :container_group_tags, :last_seen_at, :datetime
    add_index :container_group_tags, :last_seen_at

    add_column :container_image_tags, :last_seen_at, :datetime
    add_index :container_image_tags, :last_seen_at

    add_column :containers, :last_seen_at, :datetime
    add_index :containers, :last_seen_at

    add_column :container_node_tags, :last_seen_at, :datetime
    add_index :container_node_tags, :last_seen_at

    add_column :container_project_tags, :last_seen_at, :datetime
    add_index :container_project_tags, :last_seen_at

    add_column :container_template_tags, :last_seen_at, :datetime
    add_index :container_template_tags, :last_seen_at

    add_column :service_offering_icons, :last_seen_at, :datetime
    add_index :service_offering_icons, :last_seen_at

    add_column :service_offering_tags, :last_seen_at, :datetime
    add_index :service_offering_tags, :last_seen_at

    add_column :tags, :last_seen_at, :datetime
    add_index :tags, :last_seen_at
  end
end
