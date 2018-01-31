# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  first_name     :string
#  last_name      :string
#  last_update_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  telegram_id    :integer
#  status         :string
#

FactoryBot.define do
  factory :user do
    telegram_id { rand(1000) }
    first_name 'Jurgen'
    last_name 'Smirnoff'
  end
end
