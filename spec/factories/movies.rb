FactoryBot.define do
  factory :movie do
    sequence(:title)  { |n| "movie #{n}" }
    year              { rand 1960..2018 }
  end
end