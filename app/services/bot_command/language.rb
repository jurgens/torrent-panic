module BotCommand
  class Language < Base

    def process(input)
      if input.match /^\/language/
        message.send_keyboard I18n.t('commands.language.choose'), User::LANGUAGES.values
        @user.update_attribute :status, 'language'
      else
        locale = selected_locale(input)
        @user.update_attributes locale: locale, status: 'input'
        I18n.locale = locale.to_sym
        message.send_message I18n.t('commands.language.switched')
      end
    end

    def selected_locale(input)
      LANGUAGES.key(input) || User::DEFAULT_LANGUAGE
    end
  end
end
