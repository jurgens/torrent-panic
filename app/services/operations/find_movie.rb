module Operations
  class FindMovie
    BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w300'

    attr_reader :title

    def initialize(search)
      @search = search
      @title = search.text
      @user = search.user

      Tmdb::Api.key ENV['TMDB_API_KEY']
    end

    def process
      if movie.blank?
        @user.message.send_message I18n.t('errors.no_movie', title: @title)
        @search.no_movie!
      else
        if movie.poster.present?
          @user.message.send_photo movie.poster, movie.full_title
        else
          @user.message.send_message "#{movie.full_title}"
        end

        Operations::FindReleases.new(movie: movie, search: @search).process
      end
    rescue StandardError => e
      @user.message.send_message I18n.t('errors.unexpected')
      @search.error!
      Rollbar.error(e)
      raise e if Rails.env.development? || Rails.env.test?
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
      find_or_create_movie results.first # TODO: find best match
    end

    def find_or_create_movie(data)
      @movie = Movie.find_by tmdb_id: data.id
      return @movie if @movie.present?

      attributes = {
        tmdb_id: data.id,
        title: title(data),
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

    def title(data)
      _title = data.title
      _title = data.original_title if data.original_language == 'ru'
      _title
    end
  end
end
