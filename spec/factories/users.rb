FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password { '123456' }
  end
end
FactoryBot.define do
  sequence :email do |n|
    "virtude#{n}@puri.com"
  end
end
