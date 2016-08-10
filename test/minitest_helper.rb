$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'docker_machine'

require 'minitest/autorun'
require 'minitest/mock'

def run_noisy?
  ENV['NOISY'] == 'true'
end
