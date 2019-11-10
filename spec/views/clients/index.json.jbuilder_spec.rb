require 'rails_helper'

describe "clients/index.json.jbuilder", type: :view do
  before(:each) do
    @client = create(:client_with_employees)
    assign :clients, [@client, @client]
    render
  end

  attributes = %w[
    id
    ctoken
    first_name
    last_name
    created_at
    updated_at
    url
    consultants
  ]
  complex = %w[
    consultants
  ]
  consultant_attributes = %w[
    full_name
    company_name
    url
  ]

  it "renders a list of clients as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @client.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = client_url(@client, format: 'json')
    expect(hash.except! *complex).to eq expected
  end

  it "renders consultants of the clients as an array with the following attributes: #{consultant_attributes.join(', ')}" do
    hash = MultiJson.load(rendered).last
    hash = hash['consultants'].first
    expect(hash.keys.sort).to eq consultant_attributes.sort
    expected = {}
    expected['company_name'] = @client.consultants.first.company_name
    expected['full_name'] = @client.consultants.first.full_name
    expected['url'] = employee_url @client.consultants.first.employee, format: 'json'
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end
end
