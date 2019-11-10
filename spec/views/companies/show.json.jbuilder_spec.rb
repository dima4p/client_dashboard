require 'rails_helper'

describe "companies/show.json.jbuilder", type: :view do
  before(:each) do
    @company = assign(:company, create(:company_with_employees))
    render
  end

  attributes = %w[
    id
    identity
    name
    created_at
    updated_at
    clients
    contractors
    employees
  ]

  complex = %w[
    contractors
    clients
    employees
  ]

  it "renders the following attributes of company: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @company.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expect(hash.except! *complex).to eq expected
  end

  it "renders contractors of the clients as a number of client's contractors" do
    hash = MultiJson.load(rendered)
    hash = hash['contractors']
    expected = @company.contractor_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end

  it "renders clients of the clients as a number of client's clients" do
    hash = MultiJson.load(rendered)
    hash = hash['clients']
    expected = @company.client_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end

  it "renders clients of the clients as a number of client's clients" do
    hash = MultiJson.load(rendered)
    hash = hash['clients']
    expected = @company.client_ids.count
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end
end
