module Releases
  class Presenter

    include Rails.application.routes.url_helpers
    include ActionView::Helpers::UrlHelper

    attr_reader :object, :matcher

    delegate :has_link?, :magnet, to: :object

    def initialize(object)
      @object = object
    end

    def title
      match || return
      matcher[1]
    end

    def translation
      match || return
      matcher[4]
    end

    def rip_type
      match || return
      matcher[3].match(/(\S+[R|r]ip.*)$/).try(:[], 1)
    end

    def link
      release_url(object.id, host: ENV['BOT_URL'])
    end

    def size
      Size.print(object.size)
    end

    def link_with_size
      link_to size, link
    end

    def link_or_size
      has_link? ? link_with_size : size
    end

    def name
      [translation, rip_type].reject(&:blank?).join(', ')
    end

    def description
      [link_or_size, name].reject(&:blank?).join(' - ')
    end

    private

    def match
      return if object.nil?
      @matcher ||= object.title.match /^(.+)\s*\((.+)\)\s*\[(.+)\]\s*(.*)$/
    end
  end
end
