json.extract! contractor, :id, :first_name, :last_name, :created_at, :updated_at
json.partner_company do
  json.extract! contractor.partner_company, :id, :identity, :name, :created_at, :updated_at
  json.clients do
    # json.array! contractor.partner_company.clients, partial: 'clients/client', as: :client
    json.array! contractor.partner_company.clients.uniq do |client|
      json.extract! client, :id, :ctoken, :first_name, :last_name
    end
  end
  json.clients_without_employees do
    json.array! (contractor.clients - clients_with_employees) do |client|
      json.extract! client, :id, :ctoken, :first_name, :last_name
    end
  end
end
