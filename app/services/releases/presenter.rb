module Releases
  class Presenter

    attr_reader :object, :matcher

    def initialize(object)
      @object = object
    end

    def translation
      match || return
      matcher[3]
    end

    def rip_type
      match || return
      matcher[2].match(/(\S+[R|r]ip.*)$/).try(:[], 1)
    end

    def size
      Size.print(object.size)
    end

    def description
      name = [translation, rip_type].compact.join(', ')
      [name, size].compact.join(' - ')
    end

    private

    def match
      return if object.nil?
      @matcher = object.title.match /^.+\s*\((.+)\)\s*\[(.+)\]\s*(.*)$/
    end

  end
end