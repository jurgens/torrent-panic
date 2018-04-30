class Admin::SearchesController < Admin::BaseController
  def index

  end

  def collection
    @searches = Search.ordered.all.includes(:user)
  end
  helper_method :collection
end
