class WishWorker
  include Sidekiq::Worker

  def process
    Releaser.pending_movies.each do |movie|
      ReleaserWorker.perform_async(movie.id)
    end
  end
end
