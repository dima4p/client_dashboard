json.array! @employees do |employee|
  json.extract! employee, :id, :identifier, :first_name, :last_name
  json.company_name employee.company.name
  json.clients employee.client_ids.count
end
