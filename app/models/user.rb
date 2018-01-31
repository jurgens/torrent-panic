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

class User < ApplicationRecord
  include Recent

  has_many :wishes

  validates :telegram_id, uniqueness: true

  def message
    @message ||= Telegram::Message.new(telegram_id)
  end
end
