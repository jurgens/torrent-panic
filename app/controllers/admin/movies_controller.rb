class Admin::MoviesController < Admin::BaseController
  def index
    @movies = Movie.ordered.all.includes(:releases).includes(:wishes)
  end
end
