module Movies
  class FindReleases
    attr_reader :movie

    def initialize(movie)
      @movie = movie
    end

    def call
      return if @movie.recently_crawled?

      releases = tracker.search "#{@movie.title} #{@movie.year}"

      return if releases.empty?

      @movie.releases.delete_all

      releases.each do |release|
        @movie.releases << build_release(release)
      end

      @movie.touch :crawled_at
    end

    def tracker
      Rutracker.new
    end

    def build_release(item)
      attributes = {
          title: item.title,
          link: item.link,
          seeds: item.seeds,
          status: item.status,
          size: item.size,
          downloads: item.downloads
      }.merge(topic_data(item.topic_id))

      Release.new attributes
    end

    def topic_data(topic_id)
      tracker.topic_data topic_id
    rescue StandardError => e
      Rollbar.error(e)
      {}
    end
  end
end
