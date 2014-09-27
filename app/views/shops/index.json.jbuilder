json.array!(@shops) do |shop|
  json.extract! shop, :id, :name, :avatar_url, :url
  json.url shop_url(shop, format: :json)
end
