def update_or_create(model, attributes)
  obj = model.find_or_create_by!(:name => attributes[:name])
  obj.update_attributes!(attributes.except(:name))
end

update_or_create(SourceType, :name => "openshift", :product_name => "OpenShift", :vendor => "Red Hat")
update_or_create(SourceType, :name => "amazon", :product_name => "AWS", :vendor => "Amazon")
