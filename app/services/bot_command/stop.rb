module BotCommand
  class Stop < Base
    def process(search)
      super

      if input == '/stop'
        message.send_message I18n.t('commands.stop.ciao')
        user.update_attribute :status, nil
      end
    end
  end
end
