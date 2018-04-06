class Broadcast
  class << self
    def message(message)
      User.all.each do |user|
        begin
          user.message.send_message personalized_message(user, message)
        rescue StandardError => e
          Rollbar.error(e, user_id: user.id)
        end
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
