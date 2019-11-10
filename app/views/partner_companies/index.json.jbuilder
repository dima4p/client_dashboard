json.array! @partner_companies do |partner_company|
  json.partial! "partner_companies/partner_company", partner_company: partner_company
  json.url partner_company_url(partner_company, format: :json)
end
