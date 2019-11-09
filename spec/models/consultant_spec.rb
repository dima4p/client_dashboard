# == Schema Information
#
# Table name: consultants
#
#  id            :integer          not null, primary key
#  client_id     :integer
#  contractor_id :integer
#  employee_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Consultant, type: :model do
  subject(:consultant) { create :consultant }

  describe "validations" do
    it { should be_valid }
  end

  describe 'associations' do
    it {should belong_to :client}

    context 'with contractor' do
      subject {create :consultant_with_contractor}

      it 'should belong_to :contractor' do
        expect(subject.contractor).to be_present
      end
    end

    context 'wiht employee' do
      subject {create :consultant_with_employee}

      it 'should belong_to :employee' do
        expect(subject.employee).to be_present
      end
    end
  end

  describe '#full_name' do
    context 'when contractor is present' do
      subject {create :consultant_with_contractor}
      let(:contractor) {subject.contractor}

      it 'should return the #full_name of contractor' do
        expect(subject.full_name).to eq contractor.full_name
      end
    end

    context 'when employee is present' do
      subject {create :consultant_with_employee}
      let(:employee) {subject.employee}

      it 'should return the #full_name of employee' do
        expect(subject.full_name).to eq employee.full_name
      end
    end

    context 'when not contractor nor employee is present' do
      it 'returns "------"' do
        expect(subject.full_name).to eq "------"
      end
    end
  end

  describe '#company_name' do
    context 'when contractor is present' do
      subject {create :consultant_with_contractor}
      let(:contractor) {subject.contractor}

      it 'should return the #partner_company name of contractor' do
        expect(subject.company_name).to eq contractor.partner_company.name
      end
    end

    context 'when employee is present' do
      subject {create :consultant_with_employee}
      let(:employee) {subject.employee}

      it 'should return the #company.name of employee' do
        expect(subject.company_name).to eq employee.company.name
      end
    end

    context 'when not contractor nor employee is present' do
      it 'returns "------"' do
        expect(subject.company_name).to eq "------"
      end
    end
  end
end
