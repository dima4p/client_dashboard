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

  def full_name
    if contractor.present?
      contractor.full_name
    elsif employee.present?
      employee.full_name
    else
      "------"
    end
  end

  def company_name
    if contractor.present?
      contractor.partner_company.name
    elsif employee.present?
      employee.company.name
    else
      "------"
    end
  end
end
