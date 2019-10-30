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
end
