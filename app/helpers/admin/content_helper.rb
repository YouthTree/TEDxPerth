module Admin::ContentHelper
  
  def admin_content(object, field = :content)
    content_tag(:div, object.send(:"#{field}_as_html"), :class => "content")
  end
  
  def render_ted_video_editor(form)
    form.fields_for :ted_videos, TedVideo.new, :child_index => 'VIDEO_IDX' do |tvf|
      render :partial => 'video_form', :object => tvf
    end
  end
  
end