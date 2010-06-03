require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the site_overload plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the site_overload plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.title = 'SiteOverload'
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.rdoc_files.include("README.rdoc", "CHANGELOG.rdoc", 'lib/patches/actionview_ex.rb').
    exclude('lib/patches/actioncontroller_ex.rb').
    exclude('lib/patches/actionmailer_ex.rb').
    exclude('lib/patches/routeset_ex.rb').
end
