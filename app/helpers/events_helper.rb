module EventsHelper
  
  def linked_event_preview(event)
    html = first_paragraph_of(event.description_as_html)
    link = link_to "View more details &raquo;".html_safe, event
    html.gsub(/(\.|\!|\?)?\s*<\/p>/) { "#{$1 || "."} #{link}</p>" }.html_safe
  end
  
end
