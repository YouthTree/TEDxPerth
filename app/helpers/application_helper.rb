module ApplicationHelper
  
  def page_path_with_home(page)
    page.key == "home" ? root_path : page_path(page)
  end
  
  def clone_value_link(form, text, from_field, to_field, options = {})
    id_base = "##{form.send :sanitized_object_name}"
    options = options.merge "data-clone-from" => "#{id_base}_#{from_field}", "data-clone-to" => "#{id_base}_#{to_field}"
    options[:class] = [options.delete(:class), "clone-form-value"].join(" ").strip
    link_to text, '#', options
  end
  
  protected
  
  def normalized_content_scope(key, scope = nil)
    (Array(scope) + key.to_s.split(".")).flatten.join(".")
  end
  
  def options_with_class_merged(o, n)
    css_klass = [o[:class], n[:class]].join(" ").strip.squeeze(" ")
    o.merge(n).merge(:class => css_klass)
  end
  
end
