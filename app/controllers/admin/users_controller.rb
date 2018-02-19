class Admin::UsersController < Admin::BaseController
  def index

  end

  private

  def collection
    @users = User.ordered.all
  end
  helper_method :collection
end
