# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    sequence(:identifier) {|n| "AB-CD-EF-#{$1}#{format '%03d', n}" }
    company

    factory :employee_with_clients do
      transient do
        clients_count { 2 }
      end

      after(:create) do |employee, evaluator|
        create_list(:consultant, evaluator.clients_count, employee: employee)
      end
    end
  end
end
