class ContainerTemplateTag < ApplicationRecord
  belongs_to :tenant

  belongs_to :container_template
  belongs_to :tag

  acts_as_tenant(:tenant)
end
