# == Schema Information
#
# Table name: wishes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  movie_id    :integer
#  notified_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :wish do
    movie
    user
  end
end
