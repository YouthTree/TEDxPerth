module SearchHelper
  
  def possibly_empty_row(results, title)
    if results.empty?
      content_tag(:li, "We're sorry! your query didn't match any #{title.pluralize}.", :class => 'no-results')
    end
  end
  
end
