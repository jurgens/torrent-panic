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
  end

  private

  def command
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
    @message ||= webhook[:message]
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