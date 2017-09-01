# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bigapp,
  ecto_repos: [Bigapp.Repo]

# Configures the endpoint
config :bigapp, BigappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i1wdT9lGJPtee7TNRvZFborhnYL4X+Q5YkstC4egrQbWeOelTEUBYTOSTe4QWp9I",
  render_errors: [view: BigappWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bigapp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
