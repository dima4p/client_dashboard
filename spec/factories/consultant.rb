FactoryBot.define do
  factory :consultant do
    client

    factory :consultant_with_contractor do
      contractor
    end

    factory :consultant_with_employee do
      employee
    end
  end
end
