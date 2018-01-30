class Admin::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  # http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD']

  layout 'admin'
end
