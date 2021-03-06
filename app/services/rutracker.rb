require 'mechanize'

#
# Use this class to serch movei in RuTracker.org
# Usage:
# crawler = Rutracker.new
# blade_releases = crawler.search('Blade Runner')
# matrix_releases = crawler.search('The Matrix')
#
# Rutracker#search returns array of found torrents,
# each item is and Rutracker::Item instance with attributes:
# - title
# - status
# - link
# - seeds
#
# TODO: make it namespace Rutracker::Agent, Rutracker::Item, Rutracker::Client
class Rutracker
  TOP = 5

  class Agent
    LOGIN_URL = 'https://rutracker.org/forum/login.php'
    SEARCH_URL = 'https://rutracker.org/forum/tracker.php'
    TOPIC_URL = 'https://rutracker.org/forum/viewtopic.php'

    CATEGORIES = [
        187, # Классика мирового кинематографа
        2090, # Фильмы до 1990 года
        2221, # Фильмы 1991-2000
        2091, # Фильмы 2001-2005
        2092, # Фильмы 2006-2010
        2093, # Фильмы 2011-2015
        2200, # Фильмы 2016-2017
        1950, # Фильмы 2018
        2540, # Фильмы Ближнего Зарубежья
        934, # Азиатские фильмы
        505, # Индийское кино
        212, # Сборники фильмов
        941, # Кино СССР
        1666, # Детские отечественные фильмы
        376, # Авторские дебюты
        905, # Классика мирового кинематографа (DVD Video)
        1576, # Азиатские фильмы (DVD Video)
        101, # Зарубежное кино (DVD)
        100, # Наше кино (DVD)
        572, # Арт-хаус и авторское кино (DVD)
        2199, # Классика мирового кинематографа (HD Video)
        313, # Зарубежное кино (HD Video)
        2201, # Азиатские фильмы (HD Video)
        312, # Наше кино (HD Video)
        2339, # Арт-хаус и авторское кино (HD Video)
        2343, # Отечественные мультфильмы (HD Video)
        930, # Иностранные мультфильмы (HD Video)
        2365, # Иностранные короткометражные мультфильмы (HD Video)
        1900, # Отечественные мультфильмы (DVD)
        521, # Иностранные мультфильмы (DVD)
        539, # Отечественные полнометражные мультфильмы
        209, # Иностранные мультфильмы,
        599, # ANIME
        1105,
        1389,
        124, # артхаус и авторское кино,
        22,  # наше кино
    ]

    attr_reader :username, :password

    def initialize(username, password)
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Mac Safari'

      @username = username
      @password = password

      login
    end

    def search(keyword)
      @agent.get "#{SEARCH_URL}?#{params(keyword)}"
      @agent.page.search('//body')
    end

    def topic(topic_id)
      @agent.get "#{TOPIC_URL}?t=#{topic_id}"
      @agent.page.search('//body')
    end

    private

    def params(keyword)
      {
          f: CATEGORIES.join(','),
          nm: keyword,
          o: 4 # order by number of downloads
      }.to_query
    end

    def login
      @agent.post LOGIN_URL,
                  login_username: username,
                  login_password: password,
                  login: '%C2%F5%EE%E4' # Вход

      # TODO check if login was successful
    end
  end

  class Item
    include ActiveModel::Model

    STATUSES = {
      'проверено'.freeze    => :approved,
      'не проверено'.freeze => :not_approved,
      'временная'.freeze    => :temporary,
      'недооформлено'.freeze => :malformed,
      'сомнительно'.freeze  => :questionable,
    }.freeze

    BAD_STATUSES = %w{temporary}

    DEFAULT_STATUS = :not_approved

    attr_accessor :title, :link, :status, :seeds, :size, :downloads, :topic_id

    def link=(href)
      @link = "https://rutracker.org/forum/#{href}"
    end

    def status=(status)
      @status = STATUSES.fetch(status, DEFAULT_STATUS)
    end

    def good?
      !BAD_STATUSES.include?(@status)
    end
  end

  def initialize(agent = nil)
    @agent = agent || Agent.new(ENV['RUTRACKER_USERNAME'], ENV['RUTRACKER_PASSWORD'])
  end

  def search(title)
    html = @agent.search(title)
    items(html)
  end

  def topic_data(topic_id)
    html = @agent.topic(topic_id)
    magnet = html.css('a.magnet-link').attr('href').value

    {
        magnet: magnet
    }
  end

  private

  def items(html)
    html.css('#tor-tbl .hl-tr').map do |row|
      parse_item(row)
    end.reject(&:blank?).select(&:good?).slice(0, TOP)
  end

  def parse_item(row)
    Item.new(
      topic_id: parse_topic_id(row.css('a.dl-stub').attr('href').value),
      title: row.css('.tLink')[0].text,
      link: row.css('.tLink')[0]['href'],
      seeds: row.css('.seedmed')[0].text.to_i,
      status: row.css('.t-ico[title]')[0]['title'],
      size: parse_size(row.css('a.dl-stub')[0].text),
      downloads: row.css('.number-format')[0].text.to_i
    )
  rescue
    nil
  end

  def parse_size(size)
    size.gsub! /[\u0080-\u00ff]/, ' '
    Size.parse(size)
  end

  def parse_topic_id(url)
    match = url.match /\?t=(\d+)/
    return if match.blank?
    match[1].try(:to_i)
  end
end
