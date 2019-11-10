require 'rails_helper'

describe "employees/show.json.jbuilder", type: :view do
  before(:each) do
    @employee = assign(:employee, create(:employee_with_clients))
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
  ]
  complex = %w[
    clients
    company_name
  ]

  it "renders the following attributes of employee: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @employee.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['clients'] = @employee.client_ids.count
    expected['company_name'] = @employee.company_name
    expect(hash).to eq expected
  end
end
