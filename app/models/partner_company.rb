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

  scope :with_contractors_and_clients, -> do
    references(:contractors, :clients).includes(:contractors, :clients)
  end

  def client_ids
    clients.pluck(:id)
  end

  def contractor_ids
    contractors.pluck(:id)
  end

  private

  def generate_token
    while identity.blank? or self.class.exists?(identity: identity)
      self.identity = SimpleTokenGenerator::Generator.call
    end
  end
end
