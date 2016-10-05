require "../command"

module Dkit::Cli::Commands
  class Compose < ::Dkit::Command
    class Options
      arg "cmd", stop: true
      help
    end

    def run
      compose_args = find_files + find_project_name + args.values
      compose_args += env_args if args.cmd == "run"
      compose_args += unparsed_args

      exec!("docker-compose", compose_args)
    end

    private def find_files
      result = %w()
      files = config.files

      if files.is_a?(Array)
        files.each do |file_name|
          file_name = ::Dkit.env.replace(file_name)
          result << "--file #{file_name}"
        end
      end

      result
    end

    private def find_project_name
      result = %w()
      project_name = config.project_name

      if project_name.is_a?(String)
        project_name = ::Dkit.env.replace(project_name)
        result << "--project-name #{project_name}"
      end

      result
    end

    private def env_args
      result = %w()

      ::Dkit.env.vars.each do |key, value|
        result << "-e #{key}=#{value}"
      end

      result
    end

    @config : Dkit::Config::Compose | Nil
    private def config
      @config ||= ::Dkit.config.compose
    end
  end
end
