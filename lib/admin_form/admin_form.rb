module AdminForm

  module Settings

    extend ActiveSupport::Concern

    included do
      class_attribute :form_fields
    end

    def form_field_defined?(attribute)
      (self.class.form_fields || {}).with_indifferent_access.has_key?(attribute)
    end

    def form_field_type(attribute)
      (self.class.form_fields || {}).with_indifferent_access[attribute]
    end

    module ClassMethods
      def form_field(attribute, field_type)
        self.form_fields ||= {}
        self.form_fields[attribute] = field_type
      end
    end

  end

end

