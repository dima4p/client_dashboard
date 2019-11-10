# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  ctoken     :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

RSpec.describe Client, type: :model do
  subject(:client) {create :client}

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'before_validation' do
    context 'when :ctoken is blank' do
      it 'changes the value of :ctoken to be present and unique' do
        client2 = build :client, ctoken: ''
        expect{client2.valid?}.to change(client2, :ctoken)
      end
    end

    context 'when :ctoken is not unique' do
      it 'changes the value of :ctoken to be unique' do
        client2 = build :client, ctoken: client.ctoken
        expect{client2.valid?}.to change(client2, :ctoken)
      end
    end

    context 'when :ctoken is unique' do
      it 'does not changes the value of :ctoken' do
        client2 = build :client
        expect{client2.valid?}.not_to change(client2, :ctoken)
      end
    end
  end

  describe 'associations' do
    it {should have_many :consultants}

    context 'with employees' do
      subject(:client) {create :client_with_employees}

      it {should have_many :employees}
      it {should have_many :companies}

      it 'should really have companies' do
        expect(subject.companies.size).to be > 0
      end
    end

    context 'with contractors' do
      subject(:client) {create :client_with_contractors}

      it {should have_many :contractors}
      it {should have_many :partner_companies}

      it 'should really have partner_companies' do
        expect(subject.partner_companies.size).to be > 0
      end
    end
  end

  describe 'scope' do
    describe ':for_given_employees' do
      let(:employee1) { create :employee_with_clients }
      let(:employee2) { create :employee_with_clients }
      let(:employee3) { create :employee_with_clients }

      subject {described_class.for_given_employees([employee1.id, employee2.id])}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'should inlude all clients related to the employees with the given ids' do
        employee1.clients.each {|client| is_expected.to include(client)}
        employee2.clients.each {|client| is_expected.to include(client)}
      end

      it 'should not inlude all clients related to other employees' do
        employee3.clients.each {|client| is_expected.not_to include(client)}
      end
    end

    describe ':for_company' do
      let(:employee1) { create :employee_with_clients }
      let(:employee2) { create :employee_with_clients }

      subject {described_class.for_company(employee1.company_id)}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'should inlude all clients related to the employees with the given ids' do
        employee1.clients.each {|client| is_expected.to include(client)}
      end

      it 'should not inlude all clients related to other employees' do
        employee2.clients.each {|client| is_expected.not_to include(client)}
      end
    end

    describe ':for_given_contractors' do
      let(:contractor1) { create :contractor_with_clients }
      let(:contractor2) { create :contractor_with_clients }
      let(:contractor3) { create :contractor_with_clients }

      subject {described_class.for_given_contractors([contractor1.id, contractor2.id])}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'should inlude all clients related to the contractors with the given ids' do
        contractor1.clients.each {|client| is_expected.to include(client)}
        contractor2.clients.each {|client| is_expected.to include(client)}
      end

      it 'should not inlude all clients related to other contractors' do
        contractor3.clients.each {|client| is_expected.not_to include(client)}
      end
    end

    describe ':for_partner_company' do
      let(:contractor1) { create :contractor_with_clients }
      let(:contractor2) { create :contractor_with_clients }

      subject {described_class.for_partner_company(contractor1.partner_company_id)}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'should inlude all clients related to the contractors with the given ids' do
        contractor1.clients.each {|client| is_expected.to include(client)}
      end

      it 'should not inlude all clients related to other contractors' do
        contractor2.clients.each {|client| is_expected.not_to include(client)}
      end
    end

    describe ':with_consultants_and_companies' do
      let!(:contractor) {create :contractor_with_clients, clients_count: 1}
      let(:client1) {contractor.clients.firt}
      let!(:employee) {create :employee_with_clients, clients_count: 1}
      let(:client2) {employee.clients.firt}

      subject {described_class.with_consultants_and_companies}

      it "returns the ActiveRecord::Relation of #{described_class.name} of proper size" do
        is_expected.to be_an ActiveRecord::Relation
        expect(subject.map(&:consultants).flatten.size).to be 2
      end
    end

    describe ':with_employees' do
      let!(:contractor) {create :contractor_with_clients, clients_count: 1}
      let(:client1) {contractor.clients.firt}
      let!(:employee) {create :employee_with_clients, clients_count: 1}
      let(:client2) {employee.clients.firt}

      subject {described_class.with_employees}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'contains only clients that have an employee' do
        expect(subject.size).to be 1
      end
    end
  end

  describe '#full_name' do
    subject {client.full_name}

    it 'returns the first_name and last_name joined with a space' do
      is_expected.to eq [client.first_name, client.last_name].join ' '
    end
  end
end
