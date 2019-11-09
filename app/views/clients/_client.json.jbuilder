json.extract! client, :id, :ctoken, :first_name, :last_name, :created_at, :updated_at
json.employee_count client.employees.count
json.url client_url(client, format: :json)
