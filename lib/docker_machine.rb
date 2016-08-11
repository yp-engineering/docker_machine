require "docker_machine/version"

class DockerMachine

  class CLIError < StandardError
    def initialize dm, code
      super "Something went wrong with docker-machine. " \
        "Exited with code '#{code}'.\n" \
        "The STDOUT from the command was: [#{dm.out}].\n" \
        "The STDERR from the command was: [#{dm.err}]"
    end
  end

  attr_reader :err, :out

  # Public: Stupid simple interface to docker-machine cli.
  #
  # cli_args: String of direct passthrough to docker-machine. E.g.
  #           DockerMachine.new.call('ls --format "{{.Name}}"')
  #
  # opts: Hash of options for DockerMachine to use internally (default: {}).
  #       Keys are symbols
  #   :stream_logs - Boolean to either stream the command logs to STDOUT/ERR or
  #                  just save them into #out and #err (default: nil).
  #   :debug - Boolean if you would like extra output (default: nil).
  def call cli_args, opts = {}
    if opts[:stream_logs]
      err_wr = :err
      out_wr = :out
    else
      err_rd, err_wr = IO.pipe
      out_rd, out_wr = IO.pipe
    end

    cmd = "docker-machine #{cli_args}"
    puts "Command to docker-machine is: `#{cmd}`" if opts[:debug] == true

    Process.wait spawn(
      'docker-machine', *cli_args.split, err: err_wr, out: out_wr
    )

    code = $?.exitstatus
    case code
    when 0
      true
    end
  ensure
    # cleanup the pipes
    err_wr.close if err_wr.respond_to? :close
    out_wr.close if out_wr.respond_to? :close
    if out_rd.respond_to? :close
      @out = out_rd.read
      out_rd.close
    end
    if err_rd.respond_to? :close
      @err = err_rd.read
      err_rd.close
    end

    # handle exit, after because CLIError uses @err and @out
    raise DockerMachine::CLIError.new self, code if code > 0
  end

end
