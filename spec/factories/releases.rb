FactoryBot.define do
  factory :release do
    movie
    sequence(:title) { |n| "release#{n}" }
  end
end