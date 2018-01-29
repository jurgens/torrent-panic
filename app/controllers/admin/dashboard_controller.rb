class Admin::DashboardController < Admin::BaseController
  def index
    @dashboard = Dashboard.new
  end
end
