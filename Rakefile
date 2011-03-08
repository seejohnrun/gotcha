require 'spec/rake/spectask'
require File.dirname(__FILE__) + '/lib/gotcha/version'
 
task :build do
  system "gem build gotcha.gemspec"
end

task :release => :build do
  # tag and push
  system "git tag v#{Gotcha::VERSION}"
  system "git push origin --tags"
  # push the gem
  system "gem push gotcha-#{Gotcha::VERSION}.gem"
end
 
Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  fail_on_error = true # be explicit
end
 
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  fail_on_error = true # be explicit
end
