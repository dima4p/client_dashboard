# == Schema Information
#
# Table name: contractors
#
#  id                 :integer          not null, primary key
#  first_name         :string
#  last_name          :string
#  partner_company_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Contractor, type: :model do
  subject(:client) { create :contractor }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end
end
