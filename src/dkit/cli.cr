module Dkit
  class Cli < ::Cli::Supercommand
    command "compose"
    command "ssh"
    command "dns"

    class Options
      help
    end
  end
end

require "./commands/*"

# Roadmap
# dkit compose *any
# dkit dns up
# dkit dns down
# dkit ssh add
# dkit ssh down
# dit exec *any
# dkit psql
# dkit bundle install
# dkit rails s
# dkit rails c
