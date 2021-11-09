FactoryBot.define do 
  factory :proposal do 
    reason { ' Me interessei pelo projeto e quero participar ' }
    hour_value { 100 }
    hours_week { 20 }
    expectation { ' Programar bem ' }
    project
    professional
  end
end