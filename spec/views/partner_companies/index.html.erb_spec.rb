# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'partner_companies/index', type: :view do
  let!(:partner_company1) {create :partner_company}
  let!(:partner_company2) {create :partner_company}

  before(:each) do
    assign(:partner_companies, PartnerCompany.page(0))
  end

  it 'renders a list of partner_companies' do
    render
    assert_select 'tr>td', text: partner_company1.identity.to_s, count: 1
    assert_select 'tr>td', text: partner_company1.name.to_s, count: 1
    assert_select 'tr>td', text: partner_company2.name.to_s, count: 1
    assert_select 'a[href=?]', contractors_path(partner_company_id: partner_company1), count: 1
    assert_select 'a[href=?]', clients_path(partner_company_id: partner_company1), count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'Name', count: 1
    assert_select 'tr>th', text: 'Identity', count: 1
    assert_select 'tr>th', text: 'Contractors', count: 1
    assert_select 'tr>th', text: 'Clients', count: 1
  end
end
