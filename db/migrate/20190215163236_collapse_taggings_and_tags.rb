class CollapseTaggingsAndTags < ActiveRecord::Migration[5.2]
  def up
    add_reference :tags, :resource, :null => false, :polymorphic => true
    add_column    :tags, :value, :string
    add_index     :tags, [:resource_type, :resource_id, :name], :unique => true

    drop_table :taggings
  end
end
