json.array!(@videos) do |video|
  json.extract! video, :id, :url, :title, :img_url, :source_id, :source
  json.url video_url(video, format: :json)
end
