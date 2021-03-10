class ExtractTasksSourceRefFromContext < ActiveRecord::Migration[5.2]
  class Task < ActiveRecord::Base; end

  def up
    Task.find_each do |task|
      if task.context.is_a?(String)
        say "Found legacy data in Task #{task.id}, converting String to Hash..."
        task.context = JSON.parse(task.context)
      end

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
