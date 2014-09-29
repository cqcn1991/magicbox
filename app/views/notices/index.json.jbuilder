json.array!(@notices) do |notice|
  json.extract! notice, :id, :content, :pinned
  json.url notice_url(notice, format: :json)
end
