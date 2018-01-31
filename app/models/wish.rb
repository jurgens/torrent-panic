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

class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  scope :pending, -> { where(notified_at: nil) }
end
