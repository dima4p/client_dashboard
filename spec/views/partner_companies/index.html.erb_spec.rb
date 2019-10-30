# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'partner_companies/index', type: :view do
  before(:each) do
    @partner_company = create(:partner_company)
    @second_partner_company = create(:partner_company)
    assign(:partner_companies, [@partner_company, @second_partner_company])
  end

  it 'renders a list of partner_companies' do
    render
    assert_select 'tr>td', text: @partner_company.identity.to_s, count: 1
    assert_select 'tr>td', text: @partner_company.name.to_s, count: 1
    assert_select 'tr>td', text: @second_partner_company.name.to_s, count: 1
    assert_select 'a[href=?]', contractors_path(partner_company_id: @partner_company), count: 1
    assert_select 'a[href=?]', clients_path(partner_company_id: @partner_company), count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'Name', count: 1
    assert_select 'tr>th', text: 'Identity', count: 1
    assert_select 'tr>th', text: 'Contractors', count: 1
    assert_select 'tr>th', text: 'Clients', count: 1
  end
end
