class TelegramChat
  def initialize(payload)
    @payload = payload
  end

  def self.dispatch(payload)
    self.new(payload).dispatch
  end

  def dispatch

  end
end