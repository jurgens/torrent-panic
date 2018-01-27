class WebhooksController < ActionController::API

  def telegram
    TelegramChat.dispatch(payload)
    render head: :ok, body: nil
  end

  private

  def payload
    params.permit(:webhook => {})
  end
end