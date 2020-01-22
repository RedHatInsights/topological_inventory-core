class AddTenantToJoinTables < ActiveRecord::Migration[5.2]
  class Tag < ActiveRecord::Base
  end

  class ClusterTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ContainerGroupTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ContainerImageTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ContainerNodeTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ContainerProjectTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ContainerTemplateTag < ActiveRecord::Base
    belongs_to :tag
  end

  class DatastoreTag < ActiveRecord::Base
    belongs_to :tag
  end

  class HostTag < ActiveRecord::Base
    belongs_to :tag
  end

  class IpaddressTag < ActiveRecord::Base
    belongs_to :tag
  end

  class NetworkAdapterTag < ActiveRecord::Base
    belongs_to :tag
  end

  class NetworkTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ReservationTag < ActiveRecord::Base
    belongs_to :tag
  end

  class SecurityGroupTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ServiceInventoryTag < ActiveRecord::Base
    belongs_to :tag
  end

  class ServiceOfferingTag < ActiveRecord::Base
    belongs_to :tag
  end

  class SubnetTag < ActiveRecord::Base
    belongs_to :tag
  end

  class VmTag < ActiveRecord::Base
    belongs_to :tag
  end

  def up
    add_reference :cluster_tags,            :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :container_group_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :container_image_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :container_node_tags,     :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :container_project_tags,  :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :container_template_tags, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :datastore_tags,          :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :host_tags,               :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :ipaddress_tags,          :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :network_adapter_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :network_tags,            :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :reservation_tags,        :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :security_group_tags,     :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :service_inventory_tags,  :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :service_offering_tags,   :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :subnet_tags,             :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :vm_tags,                 :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}

    [
      ClusterTag,
      ContainerGroupTag,
      ContainerImageTag,
      ContainerNodeTag,
      ContainerProjectTag,
      ContainerTemplateTag,
      DatastoreTag,
      HostTag,
      IpaddressTag,
      NetworkAdapterTag,
      NetworkTag,
      ReservationTag,
      SecurityGroupTag,
      ServiceInventoryTag,
      ServiceOfferingTag,
      SubnetTag,
      VmTag,
    ].each do |klass|
      klass.find_each { |i| i.update(:tenant_id => i.tag.tenant_id) }
    end
  end

  def down
    remove_reference :cluster_tags,            :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_group_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_image_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_node_tags,     :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_project_tags,  :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :container_template_tags, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :datastore_tags,          :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :host_tags,               :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :ipaddress_tags,          :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :network_adapter_tags,    :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :network_tags,            :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :reservation_tags,        :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :security_group_tags,     :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :service_inventory_tags,  :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :service_offering_tags,   :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :subnet_tags,             :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    remove_reference :vm_tags,                 :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
  end
end
