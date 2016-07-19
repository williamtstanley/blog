FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "#{Faker::Beer.name}#{n}"}
    body {Faker::Lorem.paragraph}
  end
end
