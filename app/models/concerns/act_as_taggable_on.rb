module ActAsTaggableOn
  def acts_as_taggable_on
    class_eval do
      require "hair_trigger"

      has_many :tags, :as => :resource

      def self.taggable?
        true
      end

      trigger.after(:delete) do
        "DELETE FROM tags WHERE resource_type='#{name}' AND resource_id=OLD.id"
      end
    end
  end
end
