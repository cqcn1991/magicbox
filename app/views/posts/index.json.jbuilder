json.array!(@posts) do |post|
  json.extract! post, :id, :url, :title, :source
  json.url post_url(post, format: :json)
end
