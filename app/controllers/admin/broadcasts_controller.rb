class Admin::BroadcastsController < Admin::BaseController
  def new

  end

  def create
    Broadcast.message broadcast_params[:message]

    redirect_to new_admin_broadcast_path, notice: 'Message successfully sent'
  end

  private

  def broadcast_params
    params.permit(:message)
  end
end
