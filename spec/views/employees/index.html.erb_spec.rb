# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/index', type: :view do
  let!(:employee1) {create :employee}
  let!(:employee2) {create :employee}

  before(:each) do
    assign(:employees, Employee.page(0))
  end

  it 'renders a list of employees' do
    render
    assert_select 'tr>td', text: employee1.identifier.to_s, count: 1
    assert_select 'tr>td', text: employee1.first_name.to_s, count: 1
    assert_select 'tr>td', text: employee2.first_name.to_s, count: 1
    assert_select 'tr>td', text: employee1.last_name.to_s, count: 1
    assert_select 'tr>td', text: employee2.last_name.to_s, count: 1
    assert_select 'a[href=?]', clients_path(employee_id: employee1), count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'Identifier', count: 1
    assert_select 'tr>th', text: 'First Name', count: 1
    assert_select 'tr>th', text: 'Last Name', count: 1
    assert_select 'tr>th', text: 'Company Name', count: 1
    assert_select 'tr>th', text: 'Clients', count: 1
  end
end
