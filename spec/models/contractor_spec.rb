# == Schema Information
#
# Table name: contractors
#
#  id                 :integer          not null, primary key
#  first_name         :string
#  last_name          :string
#  partner_company_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Contractor, type: :model do
  subject(:contractor) {create :contractor}

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'associations' do
    it {should belong_to :partner_company}
    it {should have_many :consultants}
    it {should have_many :clients}
  end

  describe 'scope' do
    describe ':for_clients_of_company' do
      let(:client1) { create :client_with_contractors }
      let(:client2) { create :client_with_contractors }
      let!(:consultant1) {create :consultant_with_employee, client: client1}
      let!(:consultant2) {create :consultant_with_employee, client: client2}
      let(:company) {consultant1.employee.company}

      subject {described_class.for_clients_of_company(company.id)}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        expect(subject).to be_an ActiveRecord::Relation
      end

      it 'should inlude all contractors related to the clients of the company with the given id' do
        client1.contractors.each {|contractor| is_expected.to include(contractor)}
      end

      it 'should not inlude all contractors related to other client' do
        client2.contractors.each {|contractor| is_expected.not_to include(contractor)}
      end
    end

    describe ':for_given_clients' do
      let(:client1) { create :client_with_contractors }
      let(:client2) { create :client_with_contractors }
      let(:client3) { create :client_with_contractors }

      subject {described_class.for_given_clients([client1.id, client2.id])}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        expect(subject).to be_an ActiveRecord::Relation
      end

      it 'should inlude all contractors related to the client with the given ids' do
        client1.contractors.each {|contractor| is_expected.to include(contractor)}
        client2.contractors.each {|contractor| is_expected.to include(contractor)}
      end

      it 'should not inlude all contractors related to other client' do
        client3.contractors.each {|contractor| is_expected.not_to include(contractor)}
      end
    end

    describe ':for_partner_company' do
      let(:client) { create :client_with_contractors }
      let(:partner_company) {client.partner_companies.first}
      let(:contractor) {client.partner_companies.first.contractors.first}
      let!(:consultant) {create :consultant_with_contractor, client: client}

      subject {described_class.for_partner_company partner_company.id}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation
      end

      it 'includes only the contractors of the given PartnerCompany' do
        is_expected.to eq [contractor]
      end
    end

    describe ':with_partner_company_and_clients' do
      let!(:client) {create :client_with_contractors}

       subject {described_class.with_partner_company_and_clients}

      it "returns the ActiveRecord::Relation of #{described_class.name}" do
        is_expected.to be_an ActiveRecord::Relation

        expect(subject.map(&:partner_company).flatten.uniq.size).to be 2
      end
    end
  end

  describe '#client_ids' do
    subject {contractor.client_ids}

    it 'returns the list of client ids associated with this company' do
      is_expected.to eq contractor.clients.map &:id
    end
  end

  describe '#clients_without_employees' do
    let(:contractor) {create :contractor_with_clients, clients_count: 3}
    let(:client1) {contractor.clients.first}
    let(:client2) {contractor.clients.second}
    let(:client3) {contractor.clients.third}
    let!(:consultant1) {create :consultant_with_employee, client: client1}
    let!(:consultant2) {create :consultant_with_employee, client: client2}

    subject {contractor.clients_without_employees}

    it 'returns only those clients than do not have a consultant with employee' do
      is_expected.to eq [client3]
    end
  end

  describe '#full_name' do
    subject {contractor.full_name}

    it 'returns the first_name and last_name joined with a space' do
      is_expected.to eq [contractor.first_name, contractor.last_name].join ' '
    end
  end

  describe '#partner_company_name' do
    it 'returns the partner_company.name' do
      expect(subject.partner_company_name).to be subject.partner_company.name
    end
  end
end
