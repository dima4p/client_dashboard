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
    describe ':for_given_clients' do
      let(:client1) { create :client_with_contractors }
      let(:client2) { create :client_with_contractors }
      let(:client3) { create :client_with_contractors }

      subject {described_class.for_given_clients([client1.id, client2.id]).to_a}

      it 'should inlude all contractors related to the client with the given ids' do
        client1.contractors.each {|contractor| is_expected.to include(contractor)}
        client2.contractors.each {|contractor| is_expected.to include(contractor)}
      end

      it 'should not inlude all contractors related to other client' do
        client3.contractors.each {|contractor| is_expected.not_to include(contractor)}
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
end
