# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_lead_time/version'

Gem::Specification.new do |spec|
  spec.name          = "git-lead-time"
  spec.version       = GitLeadTime::VERSION
  spec.authors       = ["Aaron Jensen"]
  spec.email         = ["aaronjensen@gmail.com"]
  spec.summary       = %q{Show the lead time of branches merged into the current branch.}
  spec.description   = %q{Show the lead time of branches merged into the current branch.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "business_time", ">= 0.6.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>3.0.0.beta2"
  spec.add_development_dependency "chronic"
end
