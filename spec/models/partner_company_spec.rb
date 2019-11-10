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
  subject(:partner_company) {create :partner_company_with_contractors}

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

  describe 'scope' do
    describe ':with_contractors_and_clients' do
      let!(:client) {create :client_with_contractors, contractors_count: 3}
      subject {described_class.with_contractors_and_clients}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        expect(subject).to be_an ActiveRecord::Relation
        expect(subject.map(&:contractors).flatten.uniq.size).to be 3
        expect(subject.map(&:clients).flatten.uniq.size).to be 1
      end
    end
  end

  describe 'associations' do
    it {should have_many :clients}
    it {should have_many :contractors}
  end

  describe '#contractor_ids' do
    subject {partner_company.contractor_ids}

    it 'returns the list of contractor ids associated with this partner_company' do
      is_expected.to eq partner_company.contractors.map &:id
    end
  end

  describe '#client_ids' do
    subject {partner_company.client_ids}

    it 'returns the list of clients ids associated with this partner_company' do
      is_expected.to eq partner_company.clients.map &:id
    end
  end
end
