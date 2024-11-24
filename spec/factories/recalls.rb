FactoryBot.define do
  factory :recall do
    recall_date { Faker::Date.forward(days: 1) } 
    interval { 2 } 
    completed { false } 
    association :study 
  end
end