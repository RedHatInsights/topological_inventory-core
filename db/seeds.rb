def update_or_create(model, attributes)
  obj = model.find_by(:name => attributes[:name])
  if obj
    obj.update_attributes!(attributes.except(:name))
  else
    model.create!(attributes)
  end
end

update_or_create(SourceType, :name => "openshift", :product_name => "OpenShift", :vendor => "Red Hat")
update_or_create(SourceType, :name => "amazon", :product_name => "AWS", :vendor => "Amazon")
