class Releaser
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def process
    releases = tracker.search @movie.title
    return if releases.empty?

    releases.each do |release|
      movie.releases << build_release(release)
    end

    @movie.touch :crawled_at

    Notifier.new(@movie).process
  end

  def tracker
    Rutracker.new
  end

  private

  def build_release(item)
    Release.new title: item[:title],
                link: item[:link],
                seeds: item[:seeds],
                status: item[:status]

  end
end
