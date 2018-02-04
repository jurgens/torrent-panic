class Notifier
  attr_reader :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def process
    releases = suitable_releases_for?(@user)
    return if releases.empty?

    message = [@movie.title]
    releases.each do |release|
      presenter = Releases::Presenter.new(release)
      message << "<b>#{presenter.title}</b>\n#{presenter.description}"
    end
    message = message.join("\n\n")

    @user.message.send_message message
  end

  private

  def suitable_releases_for?(_user)
    # TODO: find releases based on user preferences
    @movie.releases.popular.limit(3)
  end
end
