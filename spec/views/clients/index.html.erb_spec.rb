require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    @client = create(:client)
    @second_client = create(:client)
    assign(:clients, [@client, @second_client])
  end

  it "renders a list of clients" do
    render
    assert_select 'tr>td', text: @client.ctoken.to_s, count: 1
    assert_select 'tr>td', text: @client.first_name.to_s, count: 1
    assert_select 'tr>td', text: @second_client.last_name.to_s, count: 1
  end

  it 'renders a table with columns' do
    render
    assert_select 'tr>th', text: 'First Name', count: 1
    assert_select 'tr>th', text: 'Last Name', count: 1
    assert_select 'tr>th', text: 'Consultants (Company)', count: 1
  end
end
