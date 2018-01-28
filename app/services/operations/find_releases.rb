module Operations
  class FindReleases
    attr_reader :movie

    def initialize(movie, user)
      @movie = movie
      @user = user
    end

    def process
      search_for_new_releases

      if @movie.releases.any?
        Notifier.new(@user, @movie).process
      else
        @user.wishes << Wish.new(movie: movie)
        @user.message.send_message "I will let you know when \"#{movie.title}\" is released"
      end
    end

    def tracker
      Rutracker.new
    end

    private

    def search_for_new_releases
      return if @movie.recently_crawled?

      releases = tracker.search @movie.title
      return if releases.empty?

      releases.each do |release|
        @movie.releases << build_release(release)
      end

      @movie.touch :crawled_at
    end

    def build_release(item)
      Release.new title: item.title,
                  link: item.link,
                  seeds: item.seeds,
                  status: item.status

    end
  end
end
