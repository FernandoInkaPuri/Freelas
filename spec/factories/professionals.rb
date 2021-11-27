FactoryBot.define do
  factory :professional do
    sequence(:email) { |n| "parente#{n}@puri.com" }
    password { '123456' }
  end
end
