# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker_machine/version'

Gem::Specification.new do |spec|
  spec.name          = "docker_machine"
  spec.version       = DockerMachine::VERSION
  spec.authors       = ["Adam Avilla"]
  spec.email         = ["aavilla@yp.com"]

  spec.summary       = %q{Ruby interface to docker-machine cli.}
  spec.description   = %q{Used primarily for spawning a docker swarm cluster for docker engine testing.}
  spec.homepage      = "https://github.com/yp-engineering/docker_machine"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.9"
end
