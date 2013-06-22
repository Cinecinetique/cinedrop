json.array!(@documents) do |document|
  json.extract! document, :name, :kind
  json.url document_url(document, format: :json)
end