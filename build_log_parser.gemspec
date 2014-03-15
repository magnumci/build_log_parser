require File.expand_path("../lib/build_log_parser/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "build_log_parser"
  spec.version     = BuildLogParser::VERSION
  spec.summary     = "Parse build metrics from logs"
  spec.description = "Parses various build metrics from builds logs (Rspec, Test::Unit, etc)"
  spec.homepage    = "https://github.com/magnumci/build_log_parser"
  spec.authors     = ["Dan Sosedoff"]
  spec.email       = ["dan.sosedoff@gmail.com"]
  spec.license     = "MIT"
  
  spec.add_development_dependency "rake",      "~> 10"
  spec.add_development_dependency "rspec",     "~> 2.13"
  spec.add_development_dependency "simplecov", "~> 0.8"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end