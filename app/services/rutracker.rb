class Rutracker

  class Item
    include ActiveModel::Model

    attr_accessor :title, :link, :status

    def link=(href)
      @link = "https://rutracker.org/forum/#{href}"
    end
  end

  def initialize(title)
    @title = title
  end

  def items
    @items ||= begin
      rows.map do |row|
        detect_title(row, @title)
      end.reject(&:blank?)
    end
  end

  private

  def rows
    search_results_html.css('#tor-tbl .hl-tr')
  end

  def detect_title(row, title)
    if row.css('.tLink').present? && row.css('.tLink').present? && row.css('.t-ico[title]').present?
      Item.new(
        title: row.css('.tLink')[0].text,
        link: row.css('.tLink')[0]['href'],
        status: row.css('.t-ico[title]')[0]['title']
      )
    end
  end

  def search_results_html
    Nokogiri::HTML(
      search_results_page.force_encoding("cp1251").encode("utf-8", undef: :replace)
    )
  end

  def search_results_page
    # require 'open-uri'
    # @html ||= open("http://www.threescompany.com/")
    @html ||= ''
  end

end
