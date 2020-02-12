class ContainerTemplateTag < ApplicationRecord
  belongs_to :container_template
  belongs_to :tag
  belongs_to :tenant
  acts_as_tenant(:tenant)
end
