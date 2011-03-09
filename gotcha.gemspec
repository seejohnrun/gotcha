require File.dirname(__FILE__) + '/lib/gotcha/version'

spec = Gem::Specification.new do |s|
  
  s.name = 'gotcha'
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.add_development_dependency('actionpack')
  s.description = 'A smart captcha library'
  s.email = 'john.crepezzi@patch.com'
  s.files = Dir['lib/**/*.rb'] + Dir['gotchas/*.rb']
  s.has_rdoc = true
  s.homepage = 'http://seejohnrun.github.com/gotcha/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'A captcha library for auto-generating questions'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = Gotcha::VERSION
  s.rubyforge_project = 'gotcha'

end
