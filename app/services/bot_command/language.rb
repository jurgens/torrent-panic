module BotCommand
  class Language < Base
    DEFAULT_LANGUAGE = 'en'
    LANGUAGES = {
        'en' => I18n.t('languages.en'),
        'ru' => I18n.t('languages.ru')
    }

    def process(input)
      if input.match /^\/language/
        message.send_keyboard I18n.t('commands.language.choose'), LANGUAGES.values
        @user.update_attribute :status, 'language'
      else
        locale = selected_locale(input)
        @user.update_attributes locale: locale, status: 'input'
        I18n.locale = locale.to_sym
        message.send_message I18n.t('commands.language.switched')
      end
    end

    def selected_locale(input)
      LANGUAGES.key(input) || DEFAULT_LANGUAGE
    end
  end
end
