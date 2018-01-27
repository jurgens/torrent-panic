module BotCommand
  class Base
    def initialize(user)
      @user = user
    end

    def process(input)
      raise 'Implement this method in child class'
    end
  end
end