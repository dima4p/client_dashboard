json.array! @clients do |client|
  json.partial! "clients/client", client: client
  json.url client_url(client, format: :json)
end
