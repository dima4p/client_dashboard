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

class Client < ApplicationRecord
  has_many :consultants, dependent: :destroy
  has_many :employees, through: :consultants
  has_many :contractors, through: :consultants
  has_many :companies, through: :employees
  has_many :partner_companies, through: :contractors

  validates :ctoken, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation :generate_token, on: :create

  scope :for_given_employees, -> (employee_ids) do
    joins(:employees).where('employees.id' => employee_ids)
  end
  scope :for_given_contractors, -> (contractor_ids) do
    joins(:contractors).where('contractors.id' => contractor_ids)
  end
  scope :for_company, -> (company_id) do
    joins(:companies).where('companies.id' => company_id)
  end
  scope :for_partner_company, -> (partner_company_id) do
    joins(:partner_companies).where('partner_companies.id' => partner_company_id)
  end
  scope :with_consultants_and_companies, -> do
    references(consultants: {contractor: [:partner_company], employee: [:company]})
        .includes(consultants: {contractor: [:partner_company], employee: [:company]})
  end
  scope :with_employees, -> do
    joins(:consultants).where('consultants.employee_id')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_token
    while ctoken.blank? or self.class.exists?(ctoken: ctoken)
      self.ctoken = SimpleTokenGenerator::Generator.call slices: 3, size_of_slice: 2
    end
  end
end
