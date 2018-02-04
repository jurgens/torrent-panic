module Releases
  class Presenter

    attr_reader :object, :matcher

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

    def size
      Size.print(object.size)
    end

    def description
      name = [translation, rip_type].reject(&:blank?).join(', ')
      [name, size].reject(&:blank?).join(' - ')
    end

    private

    def match
      return if object.nil?
      @matcher ||= object.title.match /^(.+)\s*\((.+)\)\s*\[(.+)\]\s*(.*)$/
    end
  end
end
