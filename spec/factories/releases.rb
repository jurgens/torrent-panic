FactoryBot.define do
  factory :release do
    movie
    sequence(:title) { |n| "release#{n}" }
    size              1400
    # magnet            'magnet:link'
  end
end
