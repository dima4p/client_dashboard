require 'rails_helper'

describe "employees/index.json.jbuilder", type: :view do
  before(:each) do
    @employee = create(:employee_with_clients)
    assign :employees, [@employee, @employee]
    render
  end

  attributes = %w[
    id
    identifier
    first_name
    last_name
    company_id
    company_name
    clients
    created_at
    updated_at
    url
  ]
  complex = %w[
    clients
    company_name
  ]

  it "renders a list of employees as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @employee.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = employee_url(@employee, format: 'json')
    expected['clients'] = @employee.client_ids.count
    expected['company_name'] = @employee.company_name
    expect(hash).to eq expected
  end
end
