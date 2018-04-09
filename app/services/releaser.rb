class Releaser

  class << self
    def pending_movies
      Movie.where(id: Wish.pending.pluck(:movie_id))
    end

    def check(movie)
      Releases::Finder.new(movie).call

      return if movie.releases.empty?

      movie.wishes.each do |wish|
        Notifier.new(wish.user, movie).process
        wish.touch :notified_at
      end
    end
  end
end
