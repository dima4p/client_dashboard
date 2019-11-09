json.array! @contractors do |contractor|
  json.extract! contractor, :id, :first_name, :last_name, :created_at, :updated_at
  json.partner_company do
    json.extract! contractor.partner_company, :id, :identity, :name, :created_at, :updated_at
    json.clients do
      # json.array! contractor.partner_company.clients, partial: 'clients/client', as: :client
      json.array! contractor.partner_company.clients.uniq do |client|
        json.extract! client, :id, :ctoken, :first_name, :last_name
        json.employee_count client.employees.count
      end
    end
  end
  json.clients_without_employees do
    json.array! contractor.clients_without_employees do |client|
      json.extract! client, :id, :ctoken, :first_name, :last_name
      json.employee_count client.employees.count
    end
  end
  json.url contractor_url(contractor, format: :json)
end
