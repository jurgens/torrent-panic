require 'telegram/bot'

module BotCommand
  class Base
    attr_reader :user, :input

    def process(search)
      @user = search.user
      @input = search.text
    end

    protected

    def message
      user.message
    end
  end
end
