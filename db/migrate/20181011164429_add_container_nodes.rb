class AddContainerNodes < ActiveRecord::Migration[5.1]
  def change
    create_table "container_nodes", :id => :bigserial do |t|
      t.references "source", :type => :bigint, :index => true
      t.string     "source_ref"
      t.string     "resource_version"
      t.string     "name"
      t.integer    "cpus"
      t.bigint     "memory"
      t.references "tenant"
      t.timestamps
      t.datetime   "deleted_at", :index => true
      t.index      %i(source_id source_ref), :unique => true
    end

    add_reference "container_groups", "container_node", :index => true
  end
end
