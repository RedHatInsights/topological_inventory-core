module ActAsTaggableOn
  def acts_as_taggable_on
    class_eval do
      def self.tagging_relation_name
        "#{name.underscore}_tags".to_sym
      end

      has_many tagging_relation_name
      has_many :tags, :through => tagging_relation_name

      def self.taggable?
        true
      end
    end
  end
end
