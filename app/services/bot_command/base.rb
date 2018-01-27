require 'telegram/bot'

module BotCommand
  class Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def process(input)
      raise 'Implement this method in child class'
    end

    protected

    def message
      user.message
    end
  end
end
