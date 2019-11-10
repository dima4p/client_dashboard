require 'rails_helper'

describe "contractors/show.json.jbuilder", type: :view do
  before(:each) do
    @contractor = assign(:contractor, create(:contractor_with_clients))
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
    clients
    clients_without_employees
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

  it "renders the following attributes of contractor: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @contractor.attributes.slice *(attributes - complex)
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = contractor_url(@contractor, format: 'json')
    expect(hash.except! *complex).to eq expected
  end
end
