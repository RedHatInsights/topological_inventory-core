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

      def taggings
        # TODO: legacy v0.0 API dependency, remove when v0.0 is removed
        public_send(:tags).map do |tag|
          {
            :tag_id => tag.id.to_s,
            :name   => tag.name,
            :value  => tag.value,
          }
        end
      end
    end
  end
end
