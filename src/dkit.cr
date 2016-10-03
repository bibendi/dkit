require "cli"
require "./dkit/version"
require "./dkit/cli"
require "./dkit/config"
require "./dkit/environment"

module Dkit
  def self.config
    @@config ||= Config.from_yaml(File.read(config_path))
  end

  def self.config_path
    ENV.fetch("DKIT_FILE", "./dkit.yml")
  end

  def self.env
    @@env ||= Environment.new(config.environment)
  end
end

exit Dkit::Cli.run(ARGV).as(Int32)
