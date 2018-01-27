module BotCommand
  class None < Base
    def process(input)
      if input == '/start'
        @user.update_attribute :status, 'start'
      end
    end
  end
end