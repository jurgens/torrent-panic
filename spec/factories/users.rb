FactoryBot.define do
  factory :user do
    telegram_id { rand(1000) }
    first_name { 'Jurgen' }
    last_name { 'Smirnoff' }
  end
end
