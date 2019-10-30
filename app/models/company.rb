# frozen_string_literal: true

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


class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :clients, through: :employees

  validates :name, presence: true
  validates :identity, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  def employee_ids
    employees.pluck(:id)
  end

  def client_ids
    clients.pluck(:id)
  end

  def contractor_ids
    Contractor.for_given_clients(client_ids).pluck(:id)
  end

  private

  def generate_token
    begin
      self.identity = SimpleTokenGenerator::Generator.call
    end while self.class.exists?(identity: identity)
  end
end
