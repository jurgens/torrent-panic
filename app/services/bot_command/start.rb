module BotCommand
  class Start < Base
    def process(input)
      if input == '/start'
        message.send_message "Congratulations! You have started using TorrentPanic!\nType a movie name that you want to watch."
        @user.update_attribute :status, 'input'
      end
    end
  end
end
