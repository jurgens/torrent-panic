class Admin::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD']
  before_action :set_locale

  layout 'admin'

  def set_locale
    I18n.locale = :en
  end
end
