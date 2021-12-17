FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "virtude#{n}@puri.com" }
    password { '123456' }
  end
end
