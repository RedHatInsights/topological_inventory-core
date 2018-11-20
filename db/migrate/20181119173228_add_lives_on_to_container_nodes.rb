class AddLivesOnToContainerNodes < ActiveRecord::Migration[5.1]
  def change
    add_reference :container_nodes, :lives_on, :index => true, :polymorphic => true
  end
end
