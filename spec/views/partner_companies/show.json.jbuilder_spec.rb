require 'rails_helper'

describe "partner_companies/show.json.jbuilder", type: :view do
  before(:each) do
    @partner_company = assign(:partner_company, create(:partner_company))
    render
  end

  attributes = %w[
    id
    identity
    name
    clients
    contractors
    created_at
    updated_at
  ]
  complex = %w[
    clients
    contractors
  ]

  it "renders the following attributes of partner_company: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @partner_company.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expect(hash.except! *complex).to eq expected
  end
end
