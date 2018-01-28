module Movies
  class Finder
    BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w300'

    attr_reader :title

    def initialize(title, user)
      @title = title
      @user = user

      Tmdb::Api.key ENV['TMDB_API_KEY']
    end

    def process
      results = find_results
      return if results.blank?

      movie = create_movie results.first

      # TODO: refactor this as a duplicate with BotCommand::Input lines 10:11
      @user.message.send_message "Found and started tracking #{movie.title}"
      Wish.create(user: @user, movie: movie)

      Releaser.new(movie).process
    end

    def find_results
      Tmdb::Movie.find @title
    end

    def create_movie(data)
      attributes = {
          tmdb_id: data.id,
          title: data.original_title,
          poster: [BASE_IMAGE_URL, data.poster_path].join,
          year: data.release_date.match(/(\d+)-\d+\d+/)[1].to_i
      }
      Movie.create attributes
    end
  end
end
