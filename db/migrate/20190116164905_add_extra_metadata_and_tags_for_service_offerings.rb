class AddExtraMetadataAndTagsForServiceOfferings < ActiveRecord::Migration[5.2]
  def change
    add_column :service_offerings, :display_name, :string
    add_column :service_offerings, :documentation_url, :string
    add_column :service_offerings, :long_description, :text
    add_column :service_offerings, :distributor, :string
    add_column :service_offerings, :support_url, :string

    create_table "service_offering_tags", :id => :serial, :force => :cascade do |t|
      t.references :tenant, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}
      t.references :tag, :type => :bigint, :index => true, :null => false, :foreign_key => {:on_delete => :cascade}

      t.string "value", :null => false, :default => ''
      t.datetime "created_at", :null => false

      t.references :service_offering, :type => :bigint, :index => false, :null => false, :foreign_key => {:on_delete => :cascade}

      t.index ["service_offering_id", "tag_id", "value"], :name => "uniq_index_on_service_offering_id_tag_id_and_value", :unique => true
    end
  end
end
