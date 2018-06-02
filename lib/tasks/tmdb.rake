namespace :tmdb do
  desc 'search for a movie'
  task :search, [:title] => :environment do |t, args|
    if args[:title].blank?
      puts "rake tmdb:search[Pulpfiction]"
      exit
    end

    Tmdb::Api.key ENV['TMDB_API_KEY']
    results = Tmdb::Movie.find args[:title]

    results.each do |data|
      puts movie(data)
    end
  end

  def movie(data)
    year = Date.parse(data.release_date).year rescue nil
    "[#{data.id}] #{data.title}, #{year} / #{data.original_title} - votes:#{data.vote_count}, popularity: #{data.popularity}"
  end
end
