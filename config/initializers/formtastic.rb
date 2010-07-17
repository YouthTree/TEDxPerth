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
