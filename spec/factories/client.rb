# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:first_name) {|n| "First_name#{format '%03d', n}" }
    sequence(:last_name) {|n| "Last_name#{format '%03d', n}" }
    sequence(:ctoken) {|n| "AB-CD-DE-#{$1}#{format '%03d', n}" }
  end
end
