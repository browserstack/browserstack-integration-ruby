# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'browserstack-automate/version'

Gem::Specification.new do |spec|
  spec.name          = "browserstack-automate"
  spec.version       = Browserstack::VERSION
  spec.authors       = [ "BrowserStack Support" ]
  spec.email         = [ "support@browserstack.com" ]

  spec.description   = %q{Run Cucumber tests on BrowserStack Automate using our Ruby integration.}
  spec.summary       = %q{Run Cucumber tests on BrowserStack Automate using our Ruby integration.}
  spec.homepage      = "https://www.browserstack.com"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "selenium-webdriver"
  spec.add_dependency "browserstack-local", "~> 1.2"
  spec.add_dependency "curb", '~> 0'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "appraisal", '~> 0'
end
