FactoryBot.define do
  factory :recall do
    recall_date { Faker::Date.forward(days: 7) } 
    interval { 1 } 
    completed { false } 
    association :study 
  end
end