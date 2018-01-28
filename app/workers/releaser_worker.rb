class ReleaserWorker
  include Sidekiq::Worker

  def perform(movie_id)
    movie = Movie.find movie_id
    Releaser.new(movie).process
  end
end
