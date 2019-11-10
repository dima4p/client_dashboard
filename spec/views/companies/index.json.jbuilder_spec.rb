require 'rails_helper'

describe "companies/index.json.jbuilder", type: :view do
  before(:each) do
    @company = create(:company_with_employees)
    assign :companies, [@company, @company]
    render
  end

  attributes = %w[
    id
    identity
    name
    created_at
    updated_at
    url
    clients
    contractors
    employees
  ]
  complex = %w[
    contractors
    clients
    employees
  ]

  it "renders a list of companies as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @company.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = company_url(@company, format: 'json')
    expect(hash.except! *complex).to eq expected
  end

  it "renders contractors of the clients as a number of client's contractors" do
    hash = MultiJson.load(rendered).last
    hash = hash['contractors']
    expected = @company.contractor_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end

  it "renders clients of the clients as a number of client's clients" do
    hash = MultiJson.load(rendered).last
    hash = hash['clients']
    expected = @company.client_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end

  it "renders clients of the clients as a number of client's clients" do
    hash = MultiJson.load(rendered).last
    hash = hash['clients']
    expected = @company.client_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end
end
