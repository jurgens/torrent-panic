class User < ApplicationRecord
  has_many :wishes

  validates :telegram_id, uniqueness: true
end
