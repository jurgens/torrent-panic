class User < ApplicationRecord
  DEFAULT_LOCALE = 'en'
  LANGUAGES = {
      'en' => I18n.t('languages.en'),
      'ru' => I18n.t('languages.ru')
  }

  include Recent

  has_many :wishes, dependent: :destroy
  has_many :wanted_movies, through: :wishes, source: :movie
  has_many :searches, dependent: :destroy

  validates :telegram_id, uniqueness: true

  scope :ordered, -> { order("updated_at DESC") }

  before_validation :set_locale, on: :create

  def message
    @message ||= Telegram::Message.new(telegram_id, locale)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_locale
    self.locale = detect_locale || DEFAULT_LOCALE
  end

  def detect_locale
    return if language.nil?
    match = language.match /(\S{2})(-\S{2})?/
    return if match.nil?
    user_language = match[1].downcase
    user_language if LANGUAGES.keys.include?(user_language)
  end
end
