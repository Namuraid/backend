# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :namuraid,
  ecto_repos: [Namuraid.Repo]

# Configures the endpoint
config :namuraid, Namuraid.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qGNfBixQQccG1FSBJ+LQB333ZX+zgArt6gF06NYgWkENMf49Huxt9mTUcXCu0xWX",
  render_errors: [view: Namuraid.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Namuraid.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
