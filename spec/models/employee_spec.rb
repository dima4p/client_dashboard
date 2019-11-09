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
  subject(:employee) { create :employee_with_clients }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :identifier}
  end

  describe 'before_validation' do
    context 'when :identifier is blank' do
      it 'changes the value of :identifier to be present and unique' do
        employee2 = build :employee, identifier: ''
        expect{employee2.valid?}.to change(employee2, :identifier)
      end
    end

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

  describe 'associations' do
    it {should belong_to :company}
    it {should have_many :consultants}
    it {should have_many :clients}
  end

  describe 'scope' do
    describe ':for_given_clients' do
      let(:client1) { create :client_with_employees }
      let(:client2) { create :client_with_employees }
      let(:client3) { create :client_with_employees }

      subject {described_class.for_given_clients([client1.id, client2.id]).to_a}

      it 'should inlude all employees related to the client with the given ids' do
        client1.employees.each {|employee| is_expected.to include(employee)}
        client2.employees.each {|employee| is_expected.to include(employee)}
      end

      it 'should not inlude all employees related to other client' do
        client3.employees.each {|employee| is_expected.not_to include(employee)}
      end
    end
  end

  describe '#client_ids' do
    subject {employee.client_ids}

    it 'returns the list of client ids associated with this company' do
      is_expected.to eq employee.clients.map &:id
    end
  end

  describe '#full_name' do
    subject {employee.full_name}

    it 'returns the first_name and last_name joined with a space' do
      is_expected.to eq [employee.first_name, employee.last_name].join ' '
    end
  end
end
