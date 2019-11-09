# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    sequence(:ctoken) {|n| "AB-CD-DE-#{$1}#{format '%03d', n}" }

    factory :client_with_employees do
      transient do
        employees_count { 2 }
      end

      after(:create) do |client, evaluator|
        create_list(:consultant_with_employee, evaluator.employees_count, client: client)
      end
    end

    factory :client_with_contractors do
      transient do
        contractors_count { 2 }
      end

      after(:create) do |client, evaluator|
        create_list(:consultant_with_contractor, evaluator.contractors_count, client: client)
      end
    end
  end
end
