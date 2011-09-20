# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jruby-management/version"

Gem::Specification.new do |s|
  s.name        = "jruby-management"
  s.version     = Jruby::Management::VERSION
  s.authors     = ["Douglas Campos"]
  s.email       = ["qmx@qmx.me"]
  s.homepage    = ""
  s.summary     = %q{JRuby Management MBeans}
  s.description = %q{JRuby JMX Management Tools}

  s.rubyforge_project = "jruby-management"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
