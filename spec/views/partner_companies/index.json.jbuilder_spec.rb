require 'rails_helper'

describe "partner_companies/index.json.jbuilder", type: :view do
  before(:each) do
    @partner_company = create(:partner_company)
    assign :partner_companies, [@partner_company, @partner_company]
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
    url
  ]
  complex = %w[
    clients
    contractors
  ]

  it "renders a list of partner_companies as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @partner_company.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = partner_company_url(@partner_company, format: 'json')
    expect(hash.except! *complex).to eq expected
  end
end
