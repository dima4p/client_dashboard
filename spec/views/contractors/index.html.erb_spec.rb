require 'rails_helper'

RSpec.describe "contractors/index", type: :view do
  let!(:contractor1) {create :contractor}
  let!(:contractor2) {create :contractor}

  before(:each) do
    assign(:contractors, Contractor.page(0))
  end

  it "renders a list of contractors" do
    render
    assert_select 'tr>td', text: contractor1.first_name.to_s, count: 1
    assert_select 'tr>td', text: contractor2.last_name.to_s, count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'First Name', count: 1
    assert_select 'tr>th', text: 'Last Name', count: 1
    assert_select 'tr>th', text: 'Partner Company Identifier', count: 1
    assert_select 'tr>th', text: 'Clients', count: 1
  end
end
