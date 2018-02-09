require 'telegram/bot'

namespace :telegram do
  desc 'init telegram bot'
  task init: :environment do

    if ENV['TELEGRAM_API_KEY'].blank?
      puts 'please set ENV variable TELEGRAM_API_KEY'
      next
    end

    if ENV['BOT_URL'].blank?
      puts 'please set ENV variable BOT_URL'
      next
    end

    @api = ::Telegram::Bot::Api.new ENV['TELEGRAM_API_KEY']
    res = @api.call 'setWebhook', url: ENV['BOT_URL'] + '/webhooks/telegram'
    puts res.inspect
  end
end
