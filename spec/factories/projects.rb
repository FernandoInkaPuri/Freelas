FactoryBot.define do
  factory :project do
    title { "Projeto Marketplace" }
    description  { "Projeto top" }
    skills  { "Ruby on rails" }
    max_value  { 100 }
    limit_date  { "#{2.week.from_now.to_date}" }
    start_date  { "#{3.weeks.from_now.to_date}" }
    end_date  { "#{2.months.from_now.to_date}" }
    modality  { 0 }
    user  
  end
end