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

  scope :with_employees_and_clients, -> do
    references(:employees, :clients).includes(:employees, :clients)
  end
  scope :with_contractors, -> do
    references(clients: [:contractors]).includes(clients: [:contractors])
  end

  def employee_ids
    employees.pluck(:id)
  end

  def client_ids
    clients.pluck(:id)
  end

  def contractor_ids
    clients.map(&:contractors).flatten.uniq.map(&:id)
  end

  private

  def generate_token
    while identity.blank? or self.class.exists?(identity: identity)
      self.identity = SimpleTokenGenerator::Generator.call
    end
  end
end
