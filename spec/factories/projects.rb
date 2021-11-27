FactoryBot.define do
  factory :project do
    title { 'Projeto Marketplace' }
    description { 'Projeto top' }
    skills { 'Ruby on rails' }
    max_value { 100 }
    limit_date  { 2.weeks.from_now.to_date.to_s }
    start_date  { 3.weeks.from_now.to_date.to_s }
    end_date  { 2.months.from_now.to_date.to_s }
    modality  { 0 }
    user
  end
end
