Gem::Specification.new do |gem|
  gem.name        = 'nosy'
  gem.version     = '0.0.4'
  gem.date        = '2012-01-02'
  gem.summary     = "Output, backup, and read all your iPhone text messages"
  gem.description = "Nosy fetches, parses and searches the iPhone's SMS database that is created on your machine each time you make a backup."
  gem.authors     = ["Philip Dudley"]
  gem.homepage    = "https://github.com/pdud/Nosy"
  gem.email       = 'pdudley89@gmail.com'
  gem.files       = `git ls-files`.split("\n")
  gem.add_dependency("sqlite3", "~> 1.3.4")
  gem.add_development_dependency("rspec", "~> 2.6.0")
end