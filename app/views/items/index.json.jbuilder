json.array!(@items) do |item|
  json.extract! item, :id, :url, :title, :img_url, :taobao_id, :shop_id
  json.url item_url(item, format: :json)
end
