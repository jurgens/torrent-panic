module Operations
  class FindMovie
    BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w300'

    attr_reader :title

    def initialize(title, user)
      @title = title
      @user = user

      Tmdb::Api.key ENV['TMDB_API_KEY']
    end

    def process
      if movie.blank?
        @user.message.send_message "No movie found with title \'#{@title}\'"
      else
        if movie.poster.present?
          @user.message.send_photo movie.poster, movie.full_title
        else
          @user.message.send_message "#{movie.full_title}"
        end

        Operations::FindReleases.new(movie, @user).process
      end
    rescue StandardError => e
      @user.message.send_message "Oops, I couldn't process your request"
      Rollbar.error(e)
    end

    def movie
      @movie ||= local_search || tmdb_search
    end

    def local_search
      Movie.limit(1).where("title LIKE ?", @title).first
    end

    def tmdb_search
      results = Tmdb::Movie.find @title
      return if results.empty?
      find_or_create_movie results.first
    end

    def find_or_create_movie(data)
      @movie = Movie.find_by tmdb_id: data.id
      return @movie if @movie.present?

      attributes = {
        tmdb_id: data.id,
        title: data.title,
        poster: poster(data.poster_path),
        year: release_year(data.release_date)
      }
      Movie.create attributes
    end

    def release_year(date)
      date.match(/(\d+)-\d+\d+/)[1].to_i rescue nil
    end

    def poster(path)
      return if path.blank?
      [BASE_IMAGE_URL, path].join
    end
  end
end
