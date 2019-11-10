json.array! @companies do |company|
  json.partial! "companies/company", company: company
  json.url company_url(company, format: :json)
end
