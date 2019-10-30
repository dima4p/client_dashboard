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
  it 'requires first name' do
    expect(build(:client, first_name: nil)).to_not be_valid
  end

  it 'requires last name' do
    expect(build(:client, last_name: nil)).to_not be_valid
  end
end
