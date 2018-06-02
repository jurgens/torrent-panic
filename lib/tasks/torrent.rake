namespace :torrent do
  desc 'torrent search'
  task :search, [:title] => :environment do |t, args|
    title = args[:title]

    tracker = Rutracker.new
    results = tracker.search "#{title}"
    results.each do |r|
      puts "#{r.title}"
    end
  end
end
