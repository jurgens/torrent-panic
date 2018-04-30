module BotCommand
  class Input < Base
    def process(search)
      FindMovieWorker.perform_async search.id
    end
  end
end
