json.extract! @contractor, :id, :first_name, :last_name, :partner_company_id, :created_at, :updated_at
json.partner_company do
  json.extract! @contractor.partner_company, :id, :identity, :name
end
json.url contractor_url(@contractor, format: :json)
