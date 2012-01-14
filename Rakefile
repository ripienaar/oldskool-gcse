require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification::new do |spec|
  spec.name = "oldskool-gcse"
  spec.version = "0.0.1"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "oldskool-gcse"
  spec.description = "description: Google Custom Search plugin for Oldskool"

  spec.files = FileList["lib/**/*.rb", "views/*.erb"]
  spec.executables = []

  spec.require_path = "lib"

  spec.has_rdoc = false
  spec.test_files = nil
  spec.add_dependency 'httparty'

  spec.extensions.push(*[])

  spec.author = "R.I.Pienaar"
  spec.email = "rip@devco.net"
  spec.homepage = "http://devco.net/"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end
