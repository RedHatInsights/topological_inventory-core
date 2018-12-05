class AddTenantAndSourceToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :taggings, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :taggings, :source, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :tags, :tenant, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
    add_reference :tags, :source, :type => :bigint, :index => true, :foreign_key => {:on_delete => :cascade}
  end
end
