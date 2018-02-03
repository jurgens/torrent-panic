class Releaser
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def process
    Movies::FindReleases.new(movie).call

    return if movie.releases.empty?

    movie.wishes.each do |wish|
      Notifier.new(wish.user, movie).process
      wish.touch :notified_at
    end
  end
end
