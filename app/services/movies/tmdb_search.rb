class Movies::TmdbSearch
  BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w300'

  def initialize
    Tmdb::Api.key ENV['TMDB_API_KEY']
  end

  def find_best(title)
    results = Tmdb::Movie.find title
    return if results.empty?
    find_or_create_movie best_match(results)
  end

  private

  def best_match(results)
    max_popularity = results.map{ |e| e.popularity }.max
    cut_margin = max_popularity * 0.25

    results.select { |e| e.popularity > cut_margin }.sort_by{ |e| e.popularity }.last
  end

  def find_or_create_movie(data)
    movie = Movie.find_by tmdb_id: data.id
    return movie if movie.present?

    attributes = {
      tmdb_id: data.id,
      title: title(data),
      poster: poster(data.poster_path),
      year: release_year(data.release_date)
    }

    Movie.create attributes
  end

  def release_year(date)
    date.match(/(\d+)-\d+\d+/)[1].to_i rescue nil
  end

  def poster(path)
    return if path.blank?
    [BASE_IMAGE_URL, path].join
  end

  def title(data)
    _title = data.title
    _title = data.original_title if data.original_language == 'ru'
    _title
  end
end
