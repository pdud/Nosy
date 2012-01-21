Gem::Specification.new do |gem|
  gem.name        = 'nosy'
  gem.version     = '0.0.5'
  gem.date        = '2012-01-08'
  gem.summary     = "Output, backup, search, and read all your iPhone text messages"
  gem.description = "Nosy fetches, parses and searches the iPhone's SMS database that is created on your machine each time you make a backup. It can export to HTML, CSV, or JSON."
  gem.authors     = ["Philip Dudley"]
  gem.homepage    = "https://github.com/pdud/Nosy"
  gem.email       = 'pdudley89@gmail.com'
  gem.files       = `git ls-files`.split("\n")
  gem.add_dependency("sqlite3", "~> 1.3.4")
  gem.add_dependency("json", "~> 1.6.4")
  gem.add_development_dependency("rspec", "~> 2.6.0")
  gem.add_development_dependency("capybara", "~> 1.1.2")
  gem.executables << 'nosy'
end
