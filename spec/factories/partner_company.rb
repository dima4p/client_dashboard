# frozen_string_literal: true

FactoryBot.define do
  factory :partner_company do
    sequence(:name) {|n| "Company Name #{format '%03d', n}" }
    sequence(:identity) {|n| "P/ABCD#{format '%03d', n}" }
  end
end
