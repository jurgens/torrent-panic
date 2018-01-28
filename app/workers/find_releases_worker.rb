class FindReleasesWorker
  include Sidekiq::Worker

  def perform(movie_id, user_id)
    movie = Movie.find movie_id
    user = User.find user_id
    Operations::FindReleases.new(movie, user).process
  end
end
