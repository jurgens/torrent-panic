module Operations
  class FindReleases
    attr_reader :movie

    def initialize(movie, user)
      @movie = movie
      @user = user
    end

    def process
      Movies::FindReleases.new(@movie).call

      if @movie.releases.any?
        Notifier.new(@user, @movie).process
      else
        @user.wishes << Wish.new(movie: movie)
        @user.message.send_message I18n.t('errors.no_releases', title: movie.title)
      end
    end
  end
end
