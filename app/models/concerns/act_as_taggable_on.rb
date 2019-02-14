module ActAsTaggableOn
  def acts_as_taggable_on
    class_eval do
      require "hair_trigger"

      def self.tagging_relation_name
        "taggings".to_sym
      end

      has_many tagging_relation_name, :as => :resource
      has_many :tags, :through => tagging_relation_name

      def self.taggable?
        true
      end

      trigger.after(:delete) do
        "DELETE FROM taggings WHERE resource_type='#{self.name}' AND resource_id=OLD.id"
      end
    end
  end
end
