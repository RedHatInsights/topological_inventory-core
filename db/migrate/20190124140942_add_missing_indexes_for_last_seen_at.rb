class AddMissingIndexesForLastSeenAt < ActiveRecord::Migration[5.2]
  def change
    add_index :container_images, :last_seen_at
    add_index :flavors, :last_seen_at
    add_index :volume_types, :last_seen_at
    add_index :volumes, :last_seen_at
  end
end
