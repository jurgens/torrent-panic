class User < ApplicationRecord
  has_many :wishes

  validates :telegram_id, uniqueness: true

  def message
    @message ||= Telegram::Message.new(telegram_id)
  end
end
