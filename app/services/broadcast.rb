class Broadcast
  class << self
    def message(message)
      User.all.each do |user|
        user.message.send_message personalized_message(user, message)
      end
    end

    def personalized_message(user, message)
      %w{first_name last_name language}.each do |attribute|
        message.gsub! "%#{attribute}%", user.send(attribute.to_sym).to_s
      end
      message
    end
  end
end
