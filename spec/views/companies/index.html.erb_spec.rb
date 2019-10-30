# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/index', type: :view do
  before(:each) do
    @company = create(:company)
    @second_company = create(:company)
    assign(:companies, [@company, @second_company])
  end

  it 'renders a list of companies' do
    render
    assert_select 'tr>td', text: @company.identity.to_s, count: 1
    assert_select 'tr>td', text: @company.name.to_s, count: 1
    assert_select 'tr>td', text: @second_company.name.to_s, count: 1
    assert_select 'a[href=?]', employees_path(company_id: @company), count: 1
    assert_select 'a[href=?]', contractors_path(company_id: @company), count: 1
    assert_select 'a[href=?]', clients_path(company_id: @company), count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'Identity', count: 1
    assert_select 'tr>th', text: 'Name', count: 1
    assert_select 'tr>th', text: 'Employees', count: 1
    assert_select 'tr>th', text: 'Contractors', count: 1
    assert_select 'tr>th', text: 'Clients', count: 1
  end
end
