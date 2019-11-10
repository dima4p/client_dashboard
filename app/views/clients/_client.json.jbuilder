json.extract! client, :id, :ctoken, :first_name, :last_name, :created_at, :updated_at
json.consultants do
  json.array! client.consultants do |consultant|
    json.full_name consultant.full_name
    json.company_name consultant.company_name
    if consultant.contractor.present?
      json.url contractor_url(consultant.contractor, format: :json)
    else
      json.url employee_url(consultant.employee, format: :json)
    end
  end
end

