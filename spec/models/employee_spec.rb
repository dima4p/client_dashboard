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
  subject(:employee) { create :employee }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :identifier}
  end

  describe 'before_validation' do
    context 'when :identifier is not unique' do
      it 'changes the value of :identifier to be unique' do
        employee2 = build :employee, identifier: employee.identifier
        expect{employee2.valid?}.to change(employee2, :identifier)
      end
    end

    context 'when :identifier is unique' do
      it 'does not changes the value of :identifier' do
        employee2 = build :employee
        expect{employee2.valid?}.not_to change(employee2, :identifier)
      end
    end
  end
end
