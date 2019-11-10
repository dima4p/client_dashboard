json.array! @employees do |employee|
  json.partial! "employees/employee", employee: employee
  json.url employee_url(employee, format: :json)
end
