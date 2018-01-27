module BotCommand
  class Stop < Base
    def process(input)
      if input == '/stop'
        message.send_message 'Okay, see you soon. TorrentPanic!'
        @user.update_attribute :status, nil
      end
    end
  end
end
