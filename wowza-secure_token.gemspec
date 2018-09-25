require File.expand_path('lib/wowza/secure_token/version', __dir__)

Gem::Specification.new do |s|
  s.name          = 'wowza-secure_token'
  s.version       = Wowza::SecureToken::VERSION
  s.platform      = Gem::Platform::RUBY
  s.date          = '2018-08-23'
  s.summary       = 'Generate secure token prefix for wowza requests.'
  s.description   = 'Generate secure token prefix for wowza requests'\
                    ' and allow configurable defaults (e.g., secret).'
  s.authors       = ['Ben Armintor', "Eric O'Hanlon"]
  s.email         = 'armintor@gmail.com'
  s.homepage      = 'https://github.com/cul/wowza-secure_token'
  s.license       = 'APACHE2'
  s.files         = Dir['lib/**/*.rb', 'lib/tasks/**/*.rake', 'bin/*',
                        'LICENSE', '*.md']
  s.require_paths = ['lib']

  s.add_development_dependency('rake', '>= 10.1')
  s.add_development_dependency('rspec', '~>3.1')
  s.add_development_dependency('rubocop', '~> 0.59.2')
  s.add_development_dependency('rubocop-rspec', '>= 1.20.1')
end
