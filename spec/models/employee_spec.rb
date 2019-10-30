# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  identifier :string
#  first_name :string
#  last_name  :string
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject(:client) { create :employee }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :identifier}
    it {should validate_uniqueness_of :identifier}
  end
end
