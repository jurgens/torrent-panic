class Movies::TmdbSearch
  BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w300'
  TITLE_YEAR_REGEX = /^(.+?)\s*,?\s*(\d+)$/

  attr_reader :title, :year

  def initialize
    Tmdb::Api.key ENV['TMDB_API_KEY']
  end

  def find_best(input)
    @title, @year = parse_input(input)
    results = search
    return if results.blank?
    find_or_create_movie best_match(results)
  end

  private

  def parse_input(input)
    match = input.match TITLE_YEAR_REGEX
    return [input, nil] if match.blank?
    
    possible_title = match[1]
    possible_year = match[2].to_i

    min_year = 1930
    max_year = Date.current.year + 2

    if (min_year..max_year).include?(possible_year)
      [possible_title, possible_year]
    else
      [input, nil]
    end
  end

  def search
    search = Tmdb::Search.new
    search.resource('movie')
    search.query(title)
    search.year(year)
    search.fetch
  end

  def best_match(results)
    max_popularity = results.map{ |e| e['popularity'] }.max
    cut_margin = max_popularity * 0.25
    results.select { |e| e['popularity'].to_f > cut_margin }.sort_by{ |e| e['popularity'].to_f }.last
  end

  def find_or_create_movie(data)
    movie = Movie.find_by tmdb_id: data['id']
    return movie if movie.present?

    attributes = {
      tmdb_id: data['id'],
      title: movie_title(data),
      poster: movie_poster(data['poster_path']),
      year: movie_release_year(data['release_date'])
    }

    Movie.create attributes
  end

  def movie_release_year(date)
    date.match(/(\d+)-\d+\d+/)[1].to_i rescue nil
  end

  def movie_poster(path)
    return if path.blank?
    [BASE_IMAGE_URL, path].join
  end

  def movie_title(data)
    _title = data['title']
    _title = data['original_title'] if data['original_language'] == 'ru'
    _title
  end
end
