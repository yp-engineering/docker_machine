require 'minitest_helper'

class TestDockerMachine < Minitest::Test

  def setup
    @cls = DockerMachine
    @dm  = @cls.new
  end

  def test_that_it_has_a_version_number
    refute_nil @cls::VERSION
  end

  def test_allows_passthrough
    assert @dm.call 'ls'
    assert_match(/NAME/, @dm.out)
  end

  def test_allows_passthrough_with_more_args
    assert @dm.call 'ls -f "NAME: {{.Name}}"'
    assert_match(/NAME/, @dm.out)
  end

  def test_fails_with_bogus_docker_machine_command
    assert_raises @cls::CLIError do
      @dm.call 'crap input'
    end
  end

  def test_fails_with_malicious_args
    file = '/tmp/not-too-malicious-but-proves-the-point'
    assert_raises @cls::CLIError do
      @dm.call "; touch #{file} ;"
    end
    assert_match(/;.*not a docker-machine command/, @dm.err)
    refute File.exist? file
  end

  # Can't figure out how to capture STDOUT from this call because I am using
  # Process.spawn and I think it has lower level control of STDOUT.
  def test_streams_output
    assert @dm.call 'ls', stream_logs: true
  end if run_noisy?

  def test_debug_works
    og_stdout, $stdout = $stdout, StringIO.new
    assert @dm.call 'ls', debug: true
    assert_match(/Command to docker-machine is.*ls/, $stdout.string)
  ensure
    $stdout = og_stdout
  end

end
