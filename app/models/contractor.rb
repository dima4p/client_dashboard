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

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :for_given_clients, -> (client_ids) { joins(:clients).where('clients.id' => client_ids) }

  def clients_without_employees
    clients - Client.joins(:consultants).where('consultants.employee_id').uniq
  end

  def client_ids
    clients.pluck(:id)
  end
end
