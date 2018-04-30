class FindMovieWorker
  include Sidekiq::Worker

  def perform(search_id)
    search = Search.find search_id
    Operations::FindMovie.new(search).process
  end
end
