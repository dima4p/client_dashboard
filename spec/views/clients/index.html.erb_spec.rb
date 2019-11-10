require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  let!(:client1) {create :client}
  let!(:client2) {create :client}

  before(:each) do
    assign(:clients, Client.page(0))
  end

  it "renders a list of clients" do
    render
    assert_select 'tr>td', text: client1.ctoken.to_s, count: 1
    assert_select 'tr>td', text: client1.first_name.to_s, count: 1
    assert_select 'tr>td', text: client2.last_name.to_s, count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'First Name', count: 1
    assert_select 'tr>th', text: 'Last Name', count: 1
    assert_select 'tr>th', text: 'Consultants (Company)', count: 1
  end
end
