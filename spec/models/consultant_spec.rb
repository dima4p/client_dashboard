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

  describe '#contractor_partner_company_name' do
    context 'when a contractor is present' do
      subject {create :consultant_with_contractor}

      it "returns then contractor's #partner_company.name" do
        expect(subject.contractor_partner_company_name)
            .to be subject.contractor.partner_company.name
      end
    end

    context 'when contractor is not present' do
      it 'returns nil' do
        expect(subject.contractor_first_name).to be_nil
      end
    end
  end

  describe '#contractor_first_name' do
    context 'when a contractor is present' do
      subject {create :consultant_with_contractor}

      it "returns then contractor's #first_name" do
        expect(subject.contractor_first_name).to be subject.contractor.first_name
      end
    end

    context 'when contractor is not present' do
      it 'returns nil' do
        expect(subject.contractor_first_name).to be_nil
      end
    end
  end

  describe '#contractor_last_name' do
    context 'when a contractor is present' do
      subject {create :consultant_with_contractor}

      it "returns then contractor's #last_name" do
        expect(subject.contractor_last_name).to be subject.contractor.last_name
      end
    end

    context 'when contractor is not present' do
      it 'returns nil' do
        expect(subject.contractor_last_name).to be_nil
      end
    end
  end

  describe '#employee_first_name' do
    context 'when a employee is present' do
      subject {create :consultant_with_employee}

      it "returns then employee's #first_name" do
        expect(subject.employee_first_name).to be subject.employee.first_name
      end
    end

    context 'when employee is not present' do
      it 'returns nil' do
        expect(subject.employee_first_name).to be_nil
      end
    end
  end

  describe '#employee_last_name' do
    context 'when a employee is present' do
      subject {create :consultant_with_employee}

      it "returns then employee's #last_name" do
        expect(subject.employee_last_name).to be subject.employee.last_name
      end
    end

    context 'when employee is not present' do
      it 'returns nil' do
        expect(subject.employee_last_name).to be_nil
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
        expect(subject.full_name).to eq "--- ---"
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
