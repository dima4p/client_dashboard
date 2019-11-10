json.extract! company, :id, :identity, :name, :created_at, :updated_at
json.employees company.employee_ids.count
json.contractors company.contractor_ids.count
json.clients company.client_ids.count
