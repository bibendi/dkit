require "../command"

module Dkit::Cli::Commands
  class Dns < ::Cli::Supercommand
    command "up"
    command "down"

    class Options
      help
    end

    module Commands
      class Up < ::Dkit::Command
        class Options
          string %w(-s --socket), var: "PATH", default: "/var/run/docker.sock"
          string %w(--ip), var: "IP", default: "172.17.0.1"
          help
        end

        def run
          exec!("docker run #{docker_args} aacebedo/dnsdock:latest-amd64")
        end

        private def docker_args
          result = %w()
          result << "--detach"
          result << "--volume #{options.socket}:/var/run/docker.sock:ro"
          result << "--restart always"
          result << "--publish #{options.ip}:53:53/udp"
          result << "--name=dnsdock"
          result.join(' ')
        end
      end

      class Down < ::Dkit::Command
        def run
          exec!("docker stop dnsdock")
          exec!("docker rm -v dnsdock")
        end
      end
    end
  end
end
