Gem::Specification.new do |gem|
  gem.name        = 'nosy'
  gem.version     = '0.0.3'
  gem.date        = '2011-11-24'
  gem.summary     = "Nosy fetches, parses and searches the iPhone's SMS database that is created on your machine each time you make a backup."
  gem.description = gem.summary
  gem.authors     = ["Philip Dudley"]
  gem.homepage    = "http://phildudley.com"
  gem.email       = 'pdudley89@gmail.com'
  gem.files       = ["lib/nosy.rb", "lib/nosy/hunter.rb", "lib/nosy/parser.rb", "lib/nosy/searcher.rb"]
  gem.add_dependency("sqlite3", "~> 1.3.4")
  gem.add_dependency("fileutils", "~> 0.7")
  gem.add_development_dependency("rspec", "~> 2.6.0")
end