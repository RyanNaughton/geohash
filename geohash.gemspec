# -*- encoding: utf-8 -*-
require File.expand_path('../lib/geohash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Naughton"]
  gem.email         = ["Ryan.J.Naughton@gmail.com"]
  gem.description   = %q{geohashing}
  gem.summary       = %q{geohashing}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "geohash"
  gem.require_paths = ["lib"]
  gem.version       = Geohash::VERSION
end
