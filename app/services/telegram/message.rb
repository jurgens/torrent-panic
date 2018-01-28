require 'telegram/bot'

module Telegram
  class Message
    attr_reader :telegram_id, :api

    def initialize(telegram_id)
      @telegram_id = telegram_id
      @api = ::Telegram::Bot::Api.new ENV['TELEGRAM_API_KEY']
    end

    def send_message(text, options = {})
      return if Rails.env.test?
      @api.call('sendMessage', chat_id: telegram_id, text: text)
    rescue
      # TODO: report to rollbar
      nil
    end

    def send_photo(url, caption = nil, options = {})
      return if Rails.env.test?
      @api.call('sendPhoto', chat_id: telegram_id, photo: url, caption: caption)
    rescue
      # TODO: report to rollbar
      nil
    end
  end
end
