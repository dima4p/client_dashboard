# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  identity   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject(:company) {create :company_with_employees}

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :name}
    it {should validate_presence_of :identity}
  end

  describe 'before_validation' do
    context 'when :identity is blank' do
      it 'changes the value of :identity to be present and unique' do
        company2 = build :company, identity: ''
        expect{company2.valid?}.to change(company2, :identity)
      end
    end

    context 'when :identity is not unique' do
      it 'changes the value of :identity to be unique' do
        company2 = build :company, identity: company.identity
        expect{company2.valid?}.to change(company2, :identity)
      end
    end

    context 'when :identity is unique' do
      it 'does not changes the value of :identity' do
        company2 = build :company
        expect{company2.valid?}.not_to change(company2, :identity)
      end
    end
  end

  describe 'associations' do
    it {should have_many :employees}
    it {should have_many :clients}
  end

  describe '#employee_ids' do
    subject {company.employee_ids}

    it 'returns the list of employee ids associated with this company' do
      is_expected.to eq company.employees.map &:id
    end
  end

  describe '#client_ids' do
    subject {company.client_ids}

    it 'returns the list of clients ids associated with this company' do
      is_expected.to eq company.clients.map &:id
    end
  end
end
