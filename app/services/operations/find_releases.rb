module Operations
  class FindReleases
    attr_reader :movie, :user, :search

    def initialize(movie:, search:)
      @movie = movie
      @user = search.user
      @search = search
    end

    def process
      Releases::Finder.new(@movie).call

      if @movie.releases.any?
        Notifier.new(@user, @movie).process
        @search.ok!
      else
        @user.wanted_movies << @movie unless @user.wanted_movies.include?(@movie)
        @user.message.send_message I18n.t('errors.no_releases', title: movie.title)
        @search.no_releases!
      end
    end
  end
end
