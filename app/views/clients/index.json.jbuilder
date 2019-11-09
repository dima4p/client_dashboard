json.array! @clients do |client|
  json.extract! client, :id, :ctoken, :first_name, :last_name, :created_at, :updated_at
  json.url client_url(client, format: :json)
  json.consultants do
    json.array! client.consultants do |consultant|
      json.full_name consultant.full_name
      json.company_name consultant.company_name
    end
  end
end
