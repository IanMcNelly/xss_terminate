# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xss_terminate}
  s.version = "0.6.1"
  s.license = 'MIT'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luke Francl", "Bing-Chang Lai"]
  s.date = %q{2017-07-21}
  s.description = %q{xss_terminate sanitizes your data before it hits the database so that you don't end up storing XSS attacks. You should still HTML-escape or HTML-sanitize the data before displaying in a HTML page.}
  s.email = %q{look@recursion.org johnny.lai@me.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]

  file_list = `git ls-files`.split
  s.files       = file_list

  s.homepage = %q{http://github.com/coupa/xss_terminate}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{xss_terminate sanitizes your data before it hits the database.}
  s.test_files = [
     "test/models/comment.rb",
     "test/models/child_entry.rb",
     "test/models/entry.rb",
     "test/models/group.rb",
     "test/models/message.rb",
     "test/models/person.rb",
     "test/schema.rb",
     "test/_setup_test.rb",
     "test/formats_test.rb",
     "test/text_sanitizer_test.rb",
     "test/xss_terminate_test.rb",
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
  end

  s.add_dependency "rails", "~> 4.2.5"
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'rake'
  s.add_development_dependency('sqlite3')
  s.add_development_dependency 'test-unit', '~> 3.1'
end

