# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence(:name) {|n| "Company Name #{format '%03d', n}" }
    sequence(:identity) {|n| "ABCD:EFGH:#{format '%03d', n}" }

    factory :company_with_employees do
      transient do
        employees_count { 2 }
      end

      after(:create) do |company, evaluator|
        create_list(:employee_with_clients, evaluator.employees_count, company: company)
      end
    end
  end
end
