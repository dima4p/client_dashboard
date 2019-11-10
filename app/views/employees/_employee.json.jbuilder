json.extract! employee, :id, :identifier, :first_name, :last_name, :company_id, :created_at, :updated_at
json.company_name employee.company.name
json.clients employee.client_ids.count
