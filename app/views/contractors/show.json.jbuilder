clients_with_employees = Client.with_employees

json.partial! "contractors/contractor", contractor: @contractor,
    clients_with_employees: clients_with_employees
json.url contractor_url(@contractor, format: :json)
