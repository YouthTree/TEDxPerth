module EventsHelper
  
  def js_for_videos
    js = @event.ted_videos.map do |video|
      "TEDxPerth.TEDVideo.add(#{video.id}, #{video.raw_embedly_response});"
    end
    javascript_tag js.join("\n")
  end
  
end
