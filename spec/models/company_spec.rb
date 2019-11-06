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
  subject(:company) { create :company }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :name}
    it {should validate_presence_of :identity}
  end

  describe 'before_validation' do
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
end
