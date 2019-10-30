# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence(:name) {|n| "Company Name #{format '%03d', n}" }
    sequence(:identity) {|n| "ABCD:EFGH:#{format '%03d', n}" }
  end
end
