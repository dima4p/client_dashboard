json.array! @partner_companies do |partner_company|
  json.extract! partner_company, :id, :identity, :name
  json.contractors partner_company.contractor_ids.count
  json.clients partner_company.client_ids.count
  json.url partner_company_url(partner_company, format: :json)
end
