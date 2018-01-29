class Dashboard
  def users
    User.count
  end

  def users_delta
    User.recent(7).count
  end

  def movies
    Movie.count
  end

  def movies_delta
    Movie.recent(7).count
  end
end
