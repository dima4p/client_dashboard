json.extract! @partner_company, :id, :identity, :name, :created_at, :updated_at
json.url company_url(@partner_company, format: :json)
