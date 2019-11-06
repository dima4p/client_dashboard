json.array! @companies do |company|
  json.extract! company, :id, :identity, :name
  json.employees company.employee_ids.count
  json.contractors company.contractor_ids.count
  json.clients company.client_ids.count
  json.url company_url(company, format: :json)
end
