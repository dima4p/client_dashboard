# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/index', type: :view do
  before(:each) do
    @employee = create(:employee)
    @second_employee = create(:employee)
    assign(:employees, [@employee, @second_employee])
  end

  it 'renders a list of employees' do
    render
    assert_select 'tr>td', text: @employee.identifier.to_s, count: 1
    assert_select 'tr>td', text: @employee.first_name.to_s, count: 1
    assert_select 'tr>td', text: @second_employee.first_name.to_s, count: 1
    assert_select 'tr>td', text: @employee.last_name.to_s, count: 1
    assert_select 'tr>td', text: @second_employee.last_name.to_s, count: 1
    assert_select 'a[href=?]', clients_path(employee_id: @employee), count: 1
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
