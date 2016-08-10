# DockerMachine

A ruby interface to interact with docker-machine executable.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docker_machine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docker_machine

## Usage

```ruby
require 'docker_machine'

dm = DockerMachine.new
dm.call 'create --driver virtualbox default' # => true
dm.out # => string of STDOUT from docker-machine command
dm.call 'brokded' # => raises DockerMachine::CLIError
dm.err # => string of STDERR from docker-machine command
dm.call 'ls', stream_logs: true # => true and outputs STDOUT and STDERR to tty
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git
commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/docker_machine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
