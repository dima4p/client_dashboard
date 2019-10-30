# frozen_string_literal: true

FactoryBot.define do
  factory :contractor do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    partner_company
  end
end
