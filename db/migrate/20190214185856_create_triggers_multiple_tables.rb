# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersMultipleTables < ActiveRecord::Migration[5.2]
  def up
    create_trigger("container_groups_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("container_groups")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ContainerGroup' AND resource_id=OLD.id;"
    end

    create_trigger("container_projects_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("container_projects")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ContainerProject' AND resource_id=OLD.id;"
    end

    create_trigger("container_nodes_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("container_nodes")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ContainerNode' AND resource_id=OLD.id;"
    end

    create_trigger("container_images_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("container_images")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ContainerImage' AND resource_id=OLD.id;"
    end

    create_trigger("container_templates_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("container_templates")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ContainerTemplate' AND resource_id=OLD.id;"
    end

    create_trigger("service_offerings_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("service_offerings")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ServiceOffering' AND resource_id=OLD.id;"
    end

    create_trigger("service_offerings_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("service_offerings")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='ServiceOffering' AND resource_id=OLD.id;"
    end

    create_trigger("vms_after_delete_row_tr", :generated => true, :compatibility => 1)
      .on("vms")
      .after(:delete) do
      "DELETE FROM tags WHERE resource_type='Vm' AND resource_id=OLD.id;"
    end
  end

  def down
    drop_trigger("container_groups_after_delete_row_tr", "container_groups", :generated => true)

    drop_trigger("container_projects_after_delete_row_tr", "container_projects", :generated => true)

    drop_trigger("container_nodes_after_delete_row_tr", "container_nodes", :generated => true)

    drop_trigger("container_images_after_delete_row_tr", "container_images", :generated => true)

    drop_trigger("container_templates_after_delete_row_tr", "container_templates", :generated => true)

    drop_trigger("service_offerings_after_delete_row_tr", "service_offerings", :generated => true)

    drop_trigger("service_offerings_after_delete_row_tr", "service_offerings", :generated => true)

    drop_trigger("vms_after_delete_row_tr", "vms", :generated => true)
  end
end
