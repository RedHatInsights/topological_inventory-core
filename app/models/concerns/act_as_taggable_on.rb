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
        public_send(self.class.tagging_relation_name).map do |tagging|
          {
            :tag_id => tagging.tag_id.to_s,
            :name   => tagging.tag.name,
            :value  => tagging.value,
          }
        end
      end
    end
  end
end
