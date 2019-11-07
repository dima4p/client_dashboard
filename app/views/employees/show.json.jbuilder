json.extract! @employee, :id, :identifier, :first_name, :last_name, :created_at, :updated_at
json.company_id @employee.company_id
json.company_name @employee.company.name
json.url employee_url(@employee, format: :json)
