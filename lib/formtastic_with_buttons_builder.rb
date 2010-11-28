# DateTime Picker Input code courtest of https://github.com/demersus/formtastic_datepicker_inputs,
# Used under a MIT license.
class FormtasticWithButtonsBuilder < Formtastic::SemanticFormBuilder

  def submit(value = "Save changes", options = {})
    @template.content_tag(:button, value, options.reverse_merge(:type => "submit", :id => "#{object_name}_submit"))
  end

  # Generates a label, using a safe buffer and a few other things along those lines.
  def label(*args)
    super(*args).gsub(/\?\s*\:\<\/label\>/, "?</label>").gsub(/\?\s*\:\s*\<abbr/, "? <abbr")
  end

  def boolean_input(method, options)
    super.gsub(":</label>", "</label>").gsub(": <abbr", " <abbr")
  end

  def dob_input(*args)
    options = args.extract_options!
    options.merge!(:start_year => (Time.now.year - 100), :end_year => Time.now.year, :selected => nil)
    args << options
    date_input(*args)
  end

  def commit_button_with_cancel(*args)
    options = args.extract_options!
    text = options.delete(:label) || args.shift
    cancel_options = options.delete(:cancel)

    if @object && @object.respond_to?(:new_record?)
      key = @object.new_record? ? :create : :update

      # Deal with some complications with ActiveRecord::Base.human_name and two name models (eg UserPost)
      # ActiveRecord::Base.human_name falls back to ActiveRecord::Base.name.humanize ("Userpost")
      # if there's no i18n, which is pretty crappy.  In this circumstance we want to detect this
      # fall back (human_name == name.humanize) and do our own thing name.underscore.humanize ("User Post")
      if @object.class.model_name.respond_to?(:human)
        object_name = @object.class.model_name.human
      else
        object_human_name = @object.class.human_name                # default is UserPost => "Userpost", but i18n may do better ("User post")
        crappy_human_name = @object.class.name.humanize             # UserPost => "Userpost"
        decent_human_name = @object.class.name.underscore.humanize  # UserPost => "User post"
        object_name = (object_human_name == crappy_human_name) ? decent_human_name : object_human_name
      end
    else
      key = :submit
      object_name = @object_name.to_s.send(self.class.label_str_method)
    end

    text = (self.localized_string(key, text, :action, :model => object_name) ||
            ::Formtastic::I18n.t(key, :model => object_name)) unless text.is_a?(::String)

    button_html = options.delete(:button_html) || {}
    button_html.merge!(:class => [button_html[:class], key].compact.join(' '))
    element_class = ['commit', options.delete(:class)].compact.join(' ') # TODO: Add class reflecting on form action.
    accesskey = (options.delete(:accesskey) || self.class.default_commit_button_accesskey) unless button_html.has_key?(:accesskey)
    button_html = button_html.merge(:accesskey => accesskey) if accesskey
    inner = Formtastic::Util.html_safe(self.submit(text, button_html))
    # Start custom code
    if cancel_options.present?
      inner << template.content_tag(:span, "or", :class => "or")
      inner << @template.link_to(cancel_options.delete(:text), cancel_options.delete(:url), cancel_options)
    end
    # End custom code
    template.content_tag(:li, inner, :class => element_class)
  end

  # Returns errors converted to a sentence, adding a full stop.
  def error_sentence(errors, options = {})
    error_class = options[:error_class] || self.class.default_inline_error_class
    error_text = errors.to_sentence.untaint.strip
    error_text << "." unless %w(? ! . :).include?(error_text[-1, 1])
    template.content_tag(:p, Formtastic::Util.html_safe(error_text), :class => error_class)
  end
  
  def datetime_picker_input(method, options = {})
    format = (options[:format] || Time::DATE_FORMATS[:default] || '%d %B %Y %I:%M %p')
    string_input(method, datetime_picker_options(format, object.send(method)).merge(options))
  end

  protected

  def datetime_picker_options(format, value = nil)
    input_options   = {:class => 'ui-datetime-picker',:value => value.try(:strftime, format)}
    wrapper_options = {:class => 'datetime'}
    return :wrapper_html => wrapper_options, :input_html => input_options
  end

end
