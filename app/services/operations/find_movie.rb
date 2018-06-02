module Operations
  class FindMovie
    attr_reader :title

    def initialize(search)
      @search = search
      @title = search.text
      @user = search.user
    end

    def process
      if movie.blank?
        @user.message.send_message I18n.t('errors.no_movie', title: @title)
        @search.no_movie!
      else
        @search.movie = @movie
        @search.save

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
      @movie ||= local_search || external_search
    end

    def local_search
      Movie.limit(1).where("title LIKE ?", @title).first
    end

    def external_search
      Movies::TmdbSearch.new.find_best(@title)
    end
  end
end
