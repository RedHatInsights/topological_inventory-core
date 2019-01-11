module ActAsTaggableOn
  def acts_as_taggable_on
    mapping_table_name = "#{self.name.underscore}_tags".to_sym

    class_eval do
      has_many mapping_table_name
      has_many :tags, :through => mapping_table_name

      def self.taggable?
        true
      end

      def self.tagging_relation_name
        "#{self.name.underscore}_tags".to_sym
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
