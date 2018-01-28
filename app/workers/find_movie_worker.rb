class FindMovieWorker
  include Sidekiq::Worker

  def perform(title, user_id)
    user = User.find user_id
    Operations::FindMovie.new(title, user).process
  end
end
