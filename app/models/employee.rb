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

class Employee < ApplicationRecord
  belongs_to :company
  has_many :consultants, dependent: :destroy
  has_many :clients, through: :consultants
  delegate :name, to: :company, prefix: true

  validates :identifier, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation :generate_token, on: :create

  scope :for_company, -> (company_id) do
    where company_id: company_id
  end
  scope :for_given_clients, -> (client_ids) do
    joins(:clients).where('clients.id' => client_ids)
  end
  scope :with_company_and_clients, -> do
    includes(:company, :clients, consultants: [:client])
        .references(:company, :clients, consultants: [:client])
  end

  def client_ids
    clients.pluck(:id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_token
    while identifier.blank? or self.class.exists?(identifier: identifier)
      self.identifier = SimpleTokenGenerator::Generator.call
    end
  end
end
