FactoryBot.define do
  factory :study do
    title { Faker::Lorem.sentence(word_count: 3) } 
    content { Faker::Lorem.paragraph(sentence_count: 2) } 
    association :user 

    after(:build) do |study|
      if File.exist?('public/images/test_image.png')
        study.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      end
    end
  end
end