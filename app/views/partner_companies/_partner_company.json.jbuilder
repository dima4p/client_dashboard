json.extract! partner_company, :id, :identity, :name, :created_at, :updated_at
json.contractors partner_company.contractor_ids.count
json.clients partner_company.client_ids.count
