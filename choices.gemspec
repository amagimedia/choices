# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name    = 'amagimedia-choices'
  gem.version = '0.4.0'

  gem.add_dependency 'hashie', '>= 0.4.0'
  gem.add_development_dependency 'minitest', '~> 5.0.6'

  gem.summary = 'Easy settings for your app'
  # gem.description = "Longer description."

  gem.authors  = ['Cloudport Team']
  gem.email    = 'cloudport.team@amagi.com'
  gem.homepage = 'https://github.com/amagimedia/choices'
  gem.license  = 'MIT'

  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', '*LICENSE*']
  gem.test_files = Dir.glob('test/test_*.rb')

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if gem.respond_to?(:metadata)
    gem.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/amagimedia'
    gem.metadata['github_repo'] = 'ssh://github.com/amagimedia/choices'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end
end
