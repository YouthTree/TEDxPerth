require 'formtastic'
ActionView::Base.send :include, Formtastic::SemanticFormHelper

# Formtastic::SemanticFormBuilder.default_text_field_size        = 50
# Formtastic::SemanticFormBuilder.all_fields_required_by_default = true
# Formtastic::SemanticFormBuilder.inline_errors                  = :sentence
# Formtastic::SemanticFormBuilder.label_str_method               = :humanize
# Formtastic::SemanticFormBuilder.collection_label_methods       = ["to_label", "display_name", "full_name", "name", "title", "username", "login", "value", "to_s"]
# Formtastic::SemanticFormBuilder.inline_order                   = [:input, :hints, :errors]

Formtastic::SemanticFormBuilder.include_blank_for_select_by_default = true
Formtastic::SemanticFormBuilder.i18n_lookups_by_default             = true
Formtastic::SemanticFormBuilder.required_string                     = proc { ::Formtastic::I18n.t(:required).html_safe }
Formtastic::SemanticFormBuilder.optional_string                     = proc { ::Formtastic::I18n.t(:optional).html_safe }
Formtastic::SemanticFormHelper.builder                              = FormtasticWithButtonsBuilder

Formtastic::SemanticFormHelper.module_eval do
  
  [:form_for, :fields_for, :remote_form_for].each do |meth|
    module_eval <<-END_SRC, __FILE__, __LINE__ + 1
      def semantic_#{meth}(record_or_name_or_array, *args, &proc)
        options = args.extract_options!
        options[:builder] ||= @@builder
        options[:html] ||= {}

        class_names = options[:html][:class] ? options[:html][:class].split(" ") : []
        class_names << "formtastic"
        class_names << case record_or_name_or_array
          when String, Symbol then record_or_name_or_array.to_s               # :post => "post"
          when Array then ActiveModel::Naming.singular(record_or_name_or_array.last.class)  # [@post, @comment] # => "comment"
          else ActiveModel::Naming.singular(record_or_name_or_array.class)                  # @post => "post"
        end
        options[:html][:class] = class_names.join(" ")
        
        with_custom_field_error_proc do
          #{meth}(record_or_name_or_array, *(args << options), &proc)
        end
      end
    END_SRC
  end
  alias :semantic_form_remote_for :semantic_remote_form_for
  
end