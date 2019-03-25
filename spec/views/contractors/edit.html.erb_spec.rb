require 'rails_helper'

RSpec.describe "contractors/edit", type: :view do
  before(:each) do
    @contractor = assign(:contractor, Contractor.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :partner_company => nil
    ))
  end

  it "renders the edit contractor form" do
    render

    assert_select "form[action=?][method=?]", contractor_path(@contractor), "post" do

      assert_select "input[name=?]", "contractor[first_name]"

      assert_select "input[name=?]", "contractor[last_name]"

      assert_select "input[name=?]", "contractor[partner_company_id]"
    end
  end
end