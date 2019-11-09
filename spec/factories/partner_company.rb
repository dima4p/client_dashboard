# frozen_string_literal: true

FactoryBot.define do
  factory :partner_company do
    sequence(:name) {|n| "Company Name #{format '%03d', n}" }
    sequence(:identity) {|n| "P/ABCD#{format '%03d', n}" }

    factory :partner_company_with_contractors do
      transient do
        contractors_count { 2 }
      end

      after(:create) do |partner_company, evaluator|
        create_list(:contractor_with_clients,
                    evaluator.contractors_count,
                    partner_company: partner_company)
      end
    end
  end
end
