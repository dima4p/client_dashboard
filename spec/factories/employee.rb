# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    sequence(:identifier) {|n| "AB-CD-EF-#{$1}#{format '%03d', n}" }
    company
  end
end
