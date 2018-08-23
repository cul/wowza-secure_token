# frozen_string_literal: true

require 'wowza/secure_token'

begin
  # This code is in a begin/rescue block so that the Rakefile is usable
  # in an environment where RSpec is unavailable (i.e. production).
  require 'rspec/core/rake_task'
  desc 'Run test suite'
  RSpec::Core::RakeTask.new(:rspec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
    spec.pattern += FileList['spec/*_spec.rb']
    spec.rspec_opts = ['--backtrace'] if ENV['CI']
  end

  require 'rubocop/rake_task'
  desc 'Run style checker'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rspec'
    task.fail_on_error = true
  end
  task default: %i[rubocop rspec]
rescue LoadError => e
  puts '[Warning] Exception creating rspec rake tasks.'\
       ' This message can be ignored in environments that intentionally do not'\
       ' pull in the RSpec gem (i.e. production).'
  puts e
end
