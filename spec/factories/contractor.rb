# frozen_string_literal: true

FactoryBot.define do
  factory :contractor do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    partner_company

    factory :contractor_with_clients do
      transient do
        clients_count { 2 }
      end

      after(:create) do |contractor, evaluator|
        create_list(:consultant, evaluator.clients_count, contractor: contractor)
      end
    end
  end
end
