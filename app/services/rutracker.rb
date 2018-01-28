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

  class Agent
    LOGIN_URL = 'https://rutracker.org/forum/login.php'
    SEARCH_URL = 'https://rutracker.org/forum/tracker.php'

    attr_reader :username, :password

    def initialize(username, password)
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Mac Safari'

      @username = username
      @password = password

      login
    end

    def search(keyword)
      # TODO: add search params (search only in "Movies" category)
      @agent.get "#{SEARCH_URL}?f=124,2198,22,33,352,4,7,921,93&nm=#{keyword}"
      @agent.page.search('//body')
    end

    private

    def login
      @agent.post LOGIN_URL,
                  login_username: username,
                  login_password: password,
                  login: '%C2%F5%EE%E4' # Вход
    end
  end

  class Item
    include ActiveModel::Model

    STATUSES = {
      'проверено'.freeze => :approved,
      'не проверено'.freeze => :not_approved
    }.freeze

    DEFAULT_STATUS = :not_approved

    attr_accessor :title, :link, :status, :seeds

    def link=(href)
      @link = "https://rutracker.org/forum/#{href}"
    end

    def status=(status)
      @status = STATUSES.fetch(status, DEFAULT_STATUS)
    end
  end

  def initialize(agent = nil)
    @agent = agent || Agent.new(ENV['RUTRACKER_USERNAME'], ENV['RUTRACKER_PASSWORD'])
  end

  def search(title)
    html = @agent.search(title)
    items(html)
  end

  private

  def items(html)
    html.css('#tor-tbl .hl-tr').map do |row|
      parse_item(row)
    end.reject(&:blank?)
  end

  def parse_item(row)
    Item.new(
      title: row.css('.tLink')[0].text,
      link: row.css('.tLink')[0]['href'],
      seeds: row.css('.seedmed')[0].text,
      status: row.css('.t-ico[title]')[0]['title']
    )
    rescue
      nil
  end

end
