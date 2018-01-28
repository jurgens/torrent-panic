class FinderWorker
  include Sidekiq::Worker

  def perform(title, user_id)
    user = User.find user_id
    Movies::Finder.new(title, user).process
  end
end
