class User < ApplicationRecord
  include Recent

  has_many :wishes

  validates :telegram_id, uniqueness: true

  scope :ordered, -> { order("created_at DESC") }

  def message
    @message ||= Telegram::Message.new(telegram_id)
  end
end
