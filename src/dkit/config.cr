require "yaml"

module Dkit
  class Config
    class Compose
      YAML.mapping(
        files: {
          type: Array(String),
          nilable: true
        },
        project_name: {
          type: String,
          nilable: true
        }
      )
    end

    YAML.mapping(
      environment: {
        type: Hash(String, String),
        default: Hash(String, String).new
      },
      compose: {
        type: ::Dkit::Config::Compose
      },
      interaction: {
        type: Hash(String, YAML::Any),
        nilable: true
      },
      provision: {
        type: Array(String),
        default: %w()
      }
    )
  end
end
