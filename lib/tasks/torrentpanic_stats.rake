task :stats => "torrentpanic:stats"

namespace :torrentpanic do
  task :stats do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << ["Services", "app/services"]
  end
end
