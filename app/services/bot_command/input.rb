module BotCommand
  class Input < Base
    def process(input)
      FindMovieWorker.perform_async input, user.id
    end
  end
end
