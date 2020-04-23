class ExtractTasksSourceRefFromContext < ActiveRecord::Migration[5.2]
  def up
    Task.find_each do |task|
      source_ref = task.context&.dig('service_instance', 'source_ref')
      next if source_ref.nil?

      say "Task: #{task.id}, Source ref: #{source_ref}"
      source_id = task.context&.dig('service_instance', 'source_id')

      task.update_attributes(:target_source_ref => source_ref.to_s,
                             :target_type       => 'ServiceInstance',
                             :source_id         => source_id)
    end
  end

  def down
    Task.update_all(:source_id => nil, :target_type => nil, :target_source_ref => nil)
  end
end
