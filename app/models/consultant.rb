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
      "#{contractor.first_name} #{contractor.last_name}"
    else
      "#{employee.first_name} #{employee.last_name}"
    end
  end

  def company_name
    if contractor.present?
      contractor.partner_company.name
    else
      employee.company.name
    end
  end
end
