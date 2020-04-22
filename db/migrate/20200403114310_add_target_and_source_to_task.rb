class AddTargetAndSourceToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :target_source_ref, :string, :null => true
    add_column :tasks, :target_type, :string, :null => true

    add_index :tasks, %i[target_type target_source_ref]

    add_reference :tasks, :source, :index => true, :null => true, :foreign_key => { :on_delete => :nullify }
  end
end
