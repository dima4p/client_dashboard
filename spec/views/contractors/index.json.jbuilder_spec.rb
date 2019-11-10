require 'rails_helper'

describe "contractors/index.json.jbuilder", type: :view do
  before(:each) do
    @contractor = create(:contractor_with_clients)
    assign :contractors, [@contractor, @contractor]
    render
  end

  attributes = %w[
    id
    first_name
    last_name
    partner_company
    created_at
    updated_at
    url
  ]
  complex = %w[
    partner_company
  ]
  partner_company_attributes = %w[
    id
    identity
    name
    created_at
    updated_at
  ]
  partner_company_complex = %w[
    clients
    clients_without_employees
  ]
  partner_company_clients_attributes = %w[
    id
    ctoken
    first_name
    last_name
  ]

  it "renders a list of contractors as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @contractor.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = contractor_url(@contractor, format: 'json')
    expect(hash.except! *complex).to eq expected
  end

  it "renders partner_company of the clients as an array with the following attributes: #{partner_company_attributes.join(', ')}" do
    hash = MultiJson.load(rendered).last
    hash = hash['partner_company']
        .slice *(partner_company_attributes - partner_company_complex)
    expect(hash.keys.sort).to eq partner_company_attributes.sort
    expected = @contractor.partner_company.attributes
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
  end
end
