class TelegramChat
  def initialize(payload)
    @payload = payload
  end

  def self.dispatch(payload)
    self.new(payload).dispatch
  end

  def dispatch
    @user = find_or_create_user
    return if duplicate_message?
    store_update_id

    command.process(message[:text])
  rescue StandardError => e
    @user.message.send_message "Oops, I couldn't process your request"
    Rollbar.error(e)
  end

  private

  def command
    chat_command || user_input
  end

  def chat_command
    match = /\/(\w+)/.match message[:text]
    return if match.nil?
    return unless %w{start stop}.include? match[1]
    "BotCommand::#{match[1].capitalize}".constantize.new(@user)
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
        User.find_or_create_by telegram_id: from[:id] do |user|
          user.first_name = from[:first_name]
          user.last_name = from[:last_name]
        end
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
