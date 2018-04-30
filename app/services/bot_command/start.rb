module BotCommand
  class Start < Base
    def process(search)
      super

      if input == '/start'
        message.send_message I18n.t('commands.start.greeting', username: user.first_name)
        user.update_attribute :status, 'input'
      end
    end
  end
end
