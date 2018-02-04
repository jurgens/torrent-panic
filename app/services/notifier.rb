class Notifier
  attr_reader :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def process
    releases = suitable_releases_for?(@user)
    return if releases.empty?

    @user.message.send_message("#{releases.count} versions available for \"#{@movie.title}\"")
  end

  private

  def suitable_releases_for?(_user)
    # TODO: find releases based on user preferences
    @movie.releases.limit(3)
  end
end
