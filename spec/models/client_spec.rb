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
  subject(:client) { create :client }

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
end
