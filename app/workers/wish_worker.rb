class WishWorker
  include Sidekiq::Worker

  def perform
    Releaser.pending_movies.each do |movie|
      ReleaserWorker.perform_async(movie.id)
    end
  end
end
