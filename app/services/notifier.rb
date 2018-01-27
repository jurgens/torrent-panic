class Notifier
  attr_reader :movie

  def initialize(movie)
    @movie = movie
    @wishes = movie.wishes.pending
  end

  def process
    @wishes.each do |wish|
      notify_user(wish)
    end
  end

  private

  def notify_user(wish)
    user = wish.user
    return if suitable_releases_for?(user).empty?

    user.message.send_message("\"#{@movie.title}\" is available!")

    wish.touch :notified_at
  end

  def suitable_releases_for?(user)
    # TODO: find releases based on user preferences
    @movie.releases
  end
end