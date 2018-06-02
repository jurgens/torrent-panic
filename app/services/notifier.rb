class Notifier
  attr_reader :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def process
    return if @user.forbidden?

    releases = suitable_releases_for?(@user)
    return if releases.empty?

    message = []
    release_titles = []

    releases.map{|e| Releases::Presenter.new(e) }.each do |release|
      release_titles << release.title
      message << release.description
    end

    message.unshift "<b>#{release_titles.first}</b>"
    message = message.join("\n\n")

    @user.message.send_message message
  rescue Telegram::Bot::Exceptions::ResponseError => e
    if e.to_s.match /Forbidden/
      @user.forbidden!
    end
  end

  private

  def suitable_releases_for?(_user)
    # TODO: find releases based on user preferences
    @movie.releases.popular.limit(3)
  end
end
