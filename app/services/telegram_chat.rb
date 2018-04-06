class TelegramChat
  def initialize(payload)
    @payload = payload
  end

  def self.dispatch(payload)
    self.new(payload).dispatch
  end

  def dispatch
    find_or_create_user
    return if duplicate_message?
    store_update_id
    command.process(message[:text])
  rescue StandardError => e
    @user.message.send_message I18n.t('errors.unexpected')
    Rollbar.error(e)
    raise e if Rails.env.development?
  end

  private

  def command
    chat_command || user_input
  end

  def chat_command
    match = /\/(\w+)/.match message[:text]
    return if match.nil?
    "BotCommand::#{match[1].capitalize}".constantize.new(@user)
  rescue
    nil
  end

  def user_input
    status = @user.status.presence || 'none'
    "BotCommand::#{status.capitalize}".constantize.new(@user)
  end

  def duplicate_message?
    @user.last_update_id == webhook[:update_id]
  end

  def store_update_id
    @user.update_attribute :last_update_id, webhook[:update_id]
  end

  def webhook
    @webhook ||= @payload[:webhook]
  end

  def message
    @message ||= webhook[:message].presence || webhook[:edited_message]
  end

  def from
    @from ||= message[:from]
  end

  def find_or_create_user
    begin
      User.transaction(requires_new: true) do
        @user = User.find_or_create_by telegram_id: from[:id]
        @user.update_attributes first_name: from[:first_name], last_name: from[:last_name], language: from[:language_code]
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
