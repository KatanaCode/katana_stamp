# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "katana_stamp/version"

Gem::Specification.new do |s|
  s.name        = "katana_stamp"
  s.version     = KatanaStamp::VERSION
  s.authors     = ["Bodacious"]
  s.email       = ["bodacious@katanacode.com"]
  s.homepage    = ""
  s.summary     = %q{A copyright stamping gem}
  s.description = %q{Adds copyright comments to .rb files within a Ruby application}

  s.rubyforge_project = "katana_stamp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "activesupport"
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rake'
end
