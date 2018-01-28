class Releaser
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def process
    search_for_new_releases
    return if @movie.releases.empty?

    movie.wishes.each do |wish|
      Notifier.new(wish.user, movie).process
      wish.touch :notified_at
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
