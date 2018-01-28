module BotCommand
  class Input < Base
    def process(input)
      movie = find_movie input

      response = if movie.present?
        if has_wish?(@user, movie)
          "You already tracking \"#{movie.title}\""
        else
          Wish.create user: user, movie: movie
          ReleaserWorker.perform_in 1, movie.id

          "Okay, started tracking \"#{movie.title}\""
        end
      else
        "Looking up \"#{input}\"..."
      end

      message.send_message response
    end

    private

    def find_movie(title)
      Movie.where("title LIKE ?", title).first
    end

    def has_wish?(user, movie)
      user.wishes.where(movie_id: movie.id).any?
    end
  end
end
