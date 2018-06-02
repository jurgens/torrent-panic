class Broadcast
  class << self
    def message(message)
      User.active.each do |user|
        begin
          user.message.send_message personalized_message(user, message)
        rescue StandardError => e
          Rollbar.error(e, user_id: user.id)
        rescue Telegram::Bot::Exceptions::ResponseError => e
          if e.to_s.match /Forbidden/
            @user.forbidden!
          end
        end
      end
    end

    def personalized_message(user, message)
      new_message = message.dup
      %w{first_name last_name language}.each do |attribute|
        new_message = new_message.gsub "%#{attribute}%", user.send(attribute.to_sym).to_s
      end
      new_message
    end
  end
end
