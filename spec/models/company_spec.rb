# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  identity   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject(:client) { create :company }

  describe "validations" do
    it { should be_valid }
    it {should validate_presence_of :name}
    it {should validate_presence_of :identity}
    it {should validate_uniqueness_of :identity}
  end
end
