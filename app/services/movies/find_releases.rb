module Movies
  class FindReleases
    attr_reader :movie

    def initialize(movie)
      @movie = movie
    end

    def call
      return if @movie.recently_crawled?

      releases = tracker.search @movie.title

      return if releases.empty?

      releases.each do |release|
        @movie.releases << build_release(release)
      end

      @movie.touch :crawled_at
    end

    def tracker
      Rutracker.new
    end

    def build_release(item)
      Release.new title: item.title,
                  link: item.link,
                  seeds: item.seeds,
                  status: item.status,
                  size: item.size,
                  downloads: item.downloads
    end
  end
end
