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

class Contractor < ApplicationRecord
  belongs_to :partner_company
  has_many :consultants, dependent: :destroy
  has_many :clients, through: :consultants
  delegate :name, to: :partner_company, prefix: true

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :for_clients_of_company, -> (company_id) do
    for_given_clients(Company.where(id: company_id).first.client_ids)
  end
  scope :for_given_clients, -> (client_ids) do
    joins(:clients).where('clients.id' => client_ids)
  end
  scope :for_partner_company, -> (partner_company_id) do
    where(partner_company_id: partner_company_id)
  end
  scope :with_partner_company_and_clients, -> do
    references(:clients, partner_company: [:clients])
        .includes(:clients, partner_company: [:clients])
  end

  def client_ids
    clients.pluck(:id)
  end

  def clients_without_employees
    # TODO: check wich method is faster
    # clients.where.not(
    #   id: Client.joins(:consultants).where('consultants.employee_id').select(:id).distinct
    # )
    clients - Client.with_employees
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
