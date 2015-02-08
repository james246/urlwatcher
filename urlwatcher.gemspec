Gem::Specification.new do |s|
  s.name        = 'urlwatcher'
  s.version     = '0.0.1'
  s.date        = '2015-02-07'
  s.summary     = "Watch a URL for the presence or absence of some markup"
  s.description = "Watch a URL for the presence or absence of some markup"
  s.authors     = ["github.com/james246"]
  s.files       = ["lib/urlwatcher.rb", "lib/urlwatcher/page.rb", "lib/urlwatcher/notifier.rb"]
  s.homepage    = "https://github.com/james246"

  s.add_dependency 'nokogiri', '>= 0'
  s.add_dependency 'mail', '>= 0'
end
