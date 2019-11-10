# == Schema Information
#
# Table name: consultants
#
#  id            :integer          not null, primary key
#  client_id     :integer
#  contractor_id :integer
#  employee_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Consultant < ApplicationRecord
  belongs_to :client
  belongs_to :contractor, optional: true
  belongs_to :employee, optional: true

  delegate :first_name, :last_name, to: :contractor, prefix: true, allow_nil: true
  delegate :first_name, :last_name, to: :employee, prefix: true, allow_nil: true
  delegate :partner_company_name, to: :contractor, prefix: true, allow_nil: true
  delegate :company_name, to: :employee, prefix: true, allow_nil: true

  def first_name
    contractor_first_name || employee_first_name || '---'
  end

  def last_name
    contractor_last_name || employee_last_name || '---'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def company_name
    contractor_partner_company_name || employee_company_name || "------"
  end
end
