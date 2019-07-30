class FloatingIpTag < ApplicationRecord
  belongs_to :floating_ip
  belongs_to :tag
end
