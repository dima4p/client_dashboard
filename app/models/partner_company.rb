# == Schema Information
#
# Table name: partner_companies
#
#  id         :integer          not null, primary key
#  identity   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PartnerCompany < ApplicationRecord
  has_many :contractors, dependent: :destroy
  has_many :clients, through: :contractors

  validates :name, presence: true
  validates :identity, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  def client_ids
    clients.pluck(:id)
  end

  def contractor_ids
    contractors.pluck(:id)
  end

  private

  def generate_token
    begin
      self.identity = SimpleTokenGenerator::Generator.call(prefix: 'P/')
    end while self.class.exists?(identity: identity)
  end
end
