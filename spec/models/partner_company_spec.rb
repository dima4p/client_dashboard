# == Schema Information
#
# Table name: partner_companies
#
#  id         :integer          not null, primary key
#  identity   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PartnerCompany, type: :model do
  subject(:partner_company) { create :partner_company }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :name}
    it {should validate_presence_of :identity}
  end

  describe 'before_validation' do
    context 'when :identity is blank' do
      it 'changes the value of :identity to be present and unique' do
        partner_company2 = build :partner_company, identity: ''
        expect{partner_company2.valid?}.to change(partner_company2, :identity)
      end
    end

    context 'when :identity is not unique' do
      it 'changes the value of :identity to be unique' do
        partner_company2 = build :partner_company, identity: partner_company.identity
        expect{partner_company2.valid?}.to change(partner_company2, :identity)
      end
    end

    context 'when :identity is unique' do
      it 'does not changes the value of :identity' do
        partner_company2 = build :partner_company
        expect{partner_company2.valid?}.not_to change(partner_company2, :identity)
      end
    end
  end
end
